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

module.exports = {
  postLoginHandler
};
