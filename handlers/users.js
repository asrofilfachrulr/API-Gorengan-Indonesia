const { nanoid } = require("nanoid");
const bcrypt = require("bcrypt");

function postNewUserHandler(pool) {
  return async (req, res) => {
    const id = `@id_user${nanoid()}`;

    const { username, email, password, name } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    try {
      await pool.query('INSERT INTO users (id, email, username, name) VALUES ($1, $2, $3, $4)', [id, email, username, name]);
      try {
        await pool.query('INSERT INTO auth (id, password) VALUES ($1, $2)', [id, hashedPassword]);
      } catch (error) {
        throw "Error adding credential";
      }
      res.status(201).json({ message: "user created" });
    } catch (error) {
      await pool.query('DELETE FROM users WHERE id = $1', [id]);
      res.status(500).json({ error: error.message });
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
      res.status(500).json({ message: "Server Error: " + e.message });
    }
  };
}

function putUserImageHandler(pool) {
  return async (req, res) => {
    if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }
    const userId = req.user.userId;

    const imageUrl = `/uploads/${req.file.filename}`;

    try {
      await pool.query('UPDATE users SET thumb = $1 WHERE id = $2', [imageUrl, userId]);

      res.status(204).json({
        message: "image is uploaded and updated",
        image_url: imageUrl
      });
    } catch (e) {
      res.status(500).json({ message: e.message });
    }
  };
}

module.exports = {
  postNewUserHandler,
  getUserHandler,
  putUserImageHandler
};
