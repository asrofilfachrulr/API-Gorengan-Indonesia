const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")

function postLoginHandler(pool) {
  return async (req, res) => {
    const {identifier, password} = req.body
    try {
      const typeIndentifier = identifier.indexOf('@') === -1 ? 'username' : 'email'
      const prepQuery = `SELECT * from user_auth  WHERE ${typeIndentifier} = ?`
      const [rows, _] = await pool.query(prepQuery, [identifier])
      if(rows.length > 0){
        const data = rows[0]
        if(await bcrypt.compare(password, data.password)){
          const token = await jwt.sign({
            userId: data.id
          }, process.env.SECRET_KEY, { expiresIn: '1d' })
          res.status(200).json({message: 'login success', token})
        } else {
          res.status(401).json({message: 'invalid credentials'})
        }
      } else {
        res.status(404).json({message: 'user not found'})
      }
    } catch (error) {
      res.status(500).json({error: error.message})
    }
  }
}

module.exports = {
  postLoginHandler
}