const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

function postLoginHandler(pool) {
  return async (req, res) => {
    const { identifier, password } = req.body;
    try {
      const typeIdentifier = identifier.indexOf('@') === -1 ? 'username' : 'email';
      const prepQuery = `SELECT * FROM user_auth WHERE ${typeIdentifier} = $1`;
      const { rows } = await pool.query(prepQuery, [identifier]);

      if (rows.length > 0) {
        const data = rows[0];

        if (await bcrypt.compare(password, data.password)) {
          const token = jwt.sign({
            userId: data.id
          }, process.env.SECRET_KEY, { expiresIn: '9999 years' });
          
          const account = {
            id: data.id,
              name: data.name,
              username: data.username,
              email: data.email,
              image_url :data.image_url
          }
          
          res.status(200).json({
            message: 'Login success',
            token,
            account
          });
        } else {
          res.status(401).json({ message: 'Invalid credentials' });
        }
      } else {
        res.status(404).json({ message: 'User not found' });
      }
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };
}

function resetPassword(pool){
  return async (req, res) => {
    const { userId } = req.user
    const { old_password, new_password } = req.body

    const encryptedNewPassword = await bcrypt.hash(new_password, 10)

    try {
      const { rows } = await pool.query("SELECT * FROM auth WHERE user_id = $1", [userId])

      if(rows.length > 0){
        data = rows[0]
        if(await bcrypt.compare(old_password, data.password)){
          await pool.query("UPDATE auth SET password = $1 WHERE user_id = $2", [encryptedNewPassword, userId])
  
          res.status(200).json({
            message: "password has been updated"
          })
        } else {
          res.status(401).json({
            message: "Unauthorized",
            error: "You are not allowed to access this resource"
          })
        }
      } else {
        res.statusu(404).json({
          message: "NotFound",
          error: `Cannot find data for user_id: ${userId}`
        })
      }
    } catch (e) {
      res.status(500).json({
        error: 'ServerError',
        message: error.message
      })
    }
  }
}

module.exports = {
  postLoginHandler,
  resetPassword
};
