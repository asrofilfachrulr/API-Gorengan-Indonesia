function getIngredientsByRecipeId(pool){
  return async (req, res) => {
    const { recipe_id } = req.params;

    if(!recipe_id){
      res.status(400).json({message: "bad request: missing recipe_id"})
      return
    }

    try {
      const { rows } = await pool.query('SELECT * FROM ingredients WHERE recipe_id = $1', [recipe_id]);
      if(rows.length > 0){
        res.json({
          message: 'success',
          data: rows
        })
      } else {
        res.status(404).json({message: `ingredients data is not found for recipe_id: ${recipe_id}`})
      }
    } catch (error) {
      res.status(500).json({
        error: 'ServerError',
        message: error.message
      })
    }
  }
}

function putIngredientsByRecipeId(pool){
  return async (req, res) => {
    const { recipe_id } = req.params
    if(!recipe_id){
      res.status(404).json({
        message: "missing recipe_id"
      })
      return
    }

    const { userId } = req.user
    const { ingredients } = req.body

    if(!ingredients){
      res.status(404).json({
        message: "missing ingredients"
      })
      return
    }

    let client
    try {
      client = await pool.connect()

      const deleteQuery = `
      DELETE FROM ingredients WHERE
      recipe_id = $1 AND
      recipe_id IN (SELECT id FROM recipes WHERE author_id = $2)`
      const deleteParams = [recipe_id, userId]
      
      let insertQuery = "INSERT INTO ingredients VALUES "

      let placeholder = 1
      for(let i = 0; i < ingredients.length; i++){
        insertQuery += `($1, $${++placeholder}, $${++placeholder}, $${++placeholder})`

        if(i < ingredients.length - 1)
          insertQuery += ", "
      }
      
      const insertParams = [recipe_id]
      insertParams.push(...ingredients.flatMap(it => {
        if(!it.qty || !it.unit || !it.name)
          throw new Error("missing required attribute(s)!")
        return [it.qty, it.unit, it.name]
      }))

      await client.query("BEGIN")
      const { rowCount: delRC } = await client.query(deleteQuery, deleteParams)
      const { rowCount: insRC} = await client.query(insertQuery, insertParams)

      await client.query("COMMIT")

      res.json({
        message: "recipe's ingredients are updated",
        rowCount: {
          insert: insRC,
          delete: delRC
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
  getIngredientsByRecipeId,
  putIngredientsByRecipeId
}