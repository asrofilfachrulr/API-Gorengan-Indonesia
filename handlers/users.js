const {nanoid} = require("nanoid")
const bcrypt = require("bcrypt")


function postNewUserHandler(pool) {
  return async (req, res) => {
    const id = `@id_user${nanoid()}`

    const {username, email, password, name} = req.body

    const hashedPassword = await bcrypt.hash(password, 10)

    try {
      await pool.query('INSERT INTO users (`id`, `email`, `username`, `name`) VALUES (?, ?, ?, ?)', [id, email, username, name])
      try {
        await pool.query(`INSERT INTO auth VALUES (?, ?)`, [id, hashedPassword])
      } catch (error) {
        throw "Error adding credential";
      }
      res.status(201);
      res.json({ message: "user created" });
    } catch (error) {
      await pool.query('DELETE FROM users WHERE id = ?', [id])
      res
      .status(500)
      .json({error: error.message})
    }
  }
}

module.exports = {
  postNewUserHandler,
}