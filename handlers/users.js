const { nanoid } = require("nanoid");
const { isEmptyString } = require("../utils");
const userStorage = require("../services/supabase/storage/user");
const bcrypt = require("bcrypt");
const {DEFAULT_IMG_URL, DEFAULT_IMG_PATH} = require("../values/default")

function postNewUserHandler(pool) {
  return async (req, res) => {
    const id = `@id_user${nanoid()}`;

    const { username, email, password, name } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    try {
      await pool.query('INSERT INTO users (id, email, username, name) VALUES ($1, $2, $3, $4)', [id, email, username, name]);
      try {
        await pool.query('INSERT INTO auth VALUES ($1, $2)', [id, hashedPassword]);
      } catch (error) {
        throw "Error adding credential";
      }
      res.status(201).json({ message: "user created" });
    } catch (error) {
      console.log(error)
      await pool.query('DELETE FROM users WHERE id = $1', [id]);
      res.status(500).json({ error: 'ServerError', message: error.message });
    }
  };
}

function getUserHandler(pool) {
  return async (req, res) => {
    const userId = req.user.userId;

    try {
      const { rows } = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);
      if (rows.length > 0) {
        const row = rows[0];
        res.status(200).json({ message: "success", data: row });
      } else {
        res.status(404).json({ message: "unexpected error: user not found" });
      }
    } catch (e) {
      res.status(500).json({ error: "ServerError ", message: e.message });
    }
  };
}

function putUserImageHandler(pool) {
  return async (req, res) => {
    if (!req.uploadedData) {
      return res.status(500).json({ message: 'Middleware Error!' });
    }

    const data = req.uploadedData;
    const { userId } = req.user;
    const imagePath = data.path;
    const imageUrl = `${process.env.SUPABASE_STORAGE_URL_PREFIX}${data.fullPath}`;

    try {
      const { rows } = await pool.query(`
      WITH OldUser AS (
        SELECT image_path as old_image_path
        FROM users
        WHERE id = $1
      )
      UPDATE users set image_url = $2, image_path = $3 where id = $1 returning (SELECT old_image_path FROM OldUser) AS old_path
      `, [userId, imageUrl, imagePath]);
      
      
      // if rows has length 0, skipping old image removal activity
      if(rows.length != 0) {
        const prevPath = rows[0].old_path
  
        // dont delete default images
        const pattern = /^default\/.+\.(\S{2,})$/
        if(!pattern.test(prevPath)) {
          await userStorage.remove(prevPath)
        }
      }

      res.status(201).json({
        message: "image is uploaded and updated",
        image_url: imageUrl,
        image_path: imagePath
      });
    } catch (e) {
      res.status(500).json({ error: 'ServerError', message: e.message });
    }
  };
}

function putUserBioHandler(pool){
  return async(req, res) => {
    const { userId } = req.user
    const { username, full_name, email } = req.body

    if(isEmptyString(username) || isEmptyString(full_name) || isEmptyString(email)){
      res.status(400).json({
        message: "ClientError",
        error: "Invalid data: empty field"
      })
      return
    }

    try {
      await pool.query("UPDATE users SET username = $1, name = $2, email = $3 WHERE id = $4", [username, full_name, email, userId])

      res.status(200).json({
        message: "user updated"
      })
    } catch (e) {
      res.status(500).json({
        error: 'ServerError',
        message: e.message
      })
    }
  }
}

function deleteUserImageHandler(pool){
  return async (req, res) => {
    const { userId } = req.user

    try {
      const { rows } = await pool.query(`
      WITH OldUser AS (
        SELECT image_path as prev_path 
        FROM users 
        WHERE id = $1
      )
      UPDATE users
      SET image_url = $2, image_path = $3
      WHERE id = $1
      RETURNING (SELECT prev_path FROM OldUser) AS prev_path
      `, [userId, DEFAULT_IMG_URL, DEFAULT_IMG_PATH])

      if (rows.length != 0) {
        const prevPath = rows[0].prev_path
        const pattern = /^default\/.+\.(\S{2,})$/
        
        if(!pattern.test(prevPath)) {
          await userStorage.remove(prevPath)
        }

        res.json({
          message: "succeed removing photo profile"
        })
      } else {
        res.status(404).json({
          message: "Unexpected Error: User Not Found"
        })
      }
    } catch (e) {
      res.status(500).json({
        message: e.message
      })
    }
  }
}

module.exports = {
  postNewUserHandler,
  getUserHandler,
  putUserImageHandler,
  putUserBioHandler,
  deleteUserImageHandler
};
