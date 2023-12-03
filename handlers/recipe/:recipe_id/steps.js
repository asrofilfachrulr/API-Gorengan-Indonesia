function getStepsByRecipeId(pool) {
  return async (req, res) => {
    const { recipe_id } = req.params;

    if (!recipe_id) {
      res.status(400).json({ message: "bad request: missing recipe_id" })
      return
    }

    try {
      const { rows } = await pool.query('SELECT * FROM steps WHERE recipe_id = $1', [recipe_id]);
      if (rows.length > 0) {
        res.json({
          message: 'success',
          data: rows
        })
      } else {
        res.status(404).json({ message: `steps data is not found for recipe_id: ${recipe_id}` })
      }
    } catch (error) {
      res.status(500).json({
        error: 'ServerError',
        message: error.message
      })
    }
  }
}

function putStepsByRecipeId(pool) {
  return async (req, res) => {
    const { recipe_id } = req.params
    const { userId } = req.user

    if (!recipe_id) {
      res.status(400).json({ message: "bad request: missing recipe_id" })
      return 
    }


    const { steps } = req.body
    if (!steps) {
      res.status(400).json({
        message: "bad request: missing steps"
      })
      return
    }

    let client

    try {
      client = await pool.connect()

      const deleteQuery = `
          DELETE FROM steps
          WHERE recipe_id = $1
          AND recipe_id IN (SELECT id FROM recipes WHERE author_id = $2)`
      const deleteParams = [recipe_id, userId]

      let insertQuery = "INSERT INTO steps VALUES "

      placeholder = 1
      for (let i = 0; i < steps.length; i++) {
        insertQuery += `($1, $${++placeholder}, $${++placeholder})`

        if (i < steps.length - 1)
          insertQuery += ", "
      }

      const insertParams = [recipe_id]
      insertParams.push(...steps.flatMap(it => {
        if(!it.number || !it.step)
          throw new Error("missing required attribute(s)!")
        return [it.number, it.step]
      }))

      await client.query("BEGIN")
      const {rowCount: delRC} = await client.query(deleteQuery, deleteParams)
      const {rowCount: insRC} = await client.query(insertQuery, insertParams)

      await client.query("COMMIT")

      res.json({
        message: "recipe' steps are updated",
        rowCount: {
          delete: delRC,
          insert: insRC
        }
      })
    } catch (e) {
      await client.query("ROLLBACK")

      res.status(500).json({
        message: e.message
      })
    } finally {
      client.release()
    }
  }
}

module.exports = {
  getStepsByRecipeId,
  putStepsByRecipeId
}