const {nanoid} = require("nanoid")
const recipeService = require("../../services/supabase/storage/recipe")

function postRecipe(pool){
  return async (req, res) => {
    const { userId } = req.user
    const data = req.uploadedData
    if(!data){
      res.status(500).json({
        mesesage: "Middleware Error"
      })
      return
    }

    const imagePath = data.path;
    const imageUrl = `${process.env.SUPABASE_STORAGE_URL_PREFIX}${data.fullPath}`;
    const recipeId = `recipe-${nanoid(16)}`

    const jsonData = JSON.parse(req.body.json)

    const {title, category, difficulty, portion, minute_duration, ingredients, steps} = jsonData

    try {
      // id, author_id, title, category, image_url, difficulty, portion, minute_duration, stars, image_path
      await pool.query("INSERT INTO recipes VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)", 
        [recipeId, userId, title, category.toLowerCase(), imageUrl, difficulty.toLowerCase(), portion, minute_duration, 0, imagePath]
      )
      
      // recipe_id, qty, unit, name
      let ingredientsQuery = "INSERT INTO ingredients VALUES "

      let placeholder = 1
      for(let i = 0; i < ingredients.length; i++){
        ingredientsQuery += `($1, $${++placeholder}, $${++placeholder}, $${++placeholder})`

        if(i < ingredients.length - 1)
          ingredientsQuery += ", "
      }
      
      const ingredientsParams = [recipeId]
      ingredientsParams.push(...ingredients.flatMap(it => [it.qty, it.unit, it.name]))

      await pool.query(ingredientsQuery, ingredientsParams)

      // recipe_id, number, step
      let stepsQuery = "INSERT INTO steps VALUES "

      placeholder = 1
      for(let i = 0; i < steps.length; i++){
        stepsQuery += `($1, $${++placeholder}, $${++placeholder})`

        if(i < steps.length - 1)
          stepsQuery += ", "
      }
      
      const stepsParams = [recipeId]
      stepsParams.push(...steps.flatMap(it => [it.number, it.step]))
      
      await pool.query(stepsQuery, stepsParams)
      
      const { rows } = await pool.query("SELECT * FROM recipes WHERE id = $1", [recipeId])

      res.status(201).json({
        message: "recipe created",
        data: rows  
      })
    } catch (e) {
      await recipeService.remove(imagePath)
      await pool.query("DELETE FROM recipes WHERE id = $1", [recipeId])

      res.status(500).json({
        message: e.message,
        body: jsonData
      })
    }
  }
}

function putRecipe(pool){
  return async (req, res) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    if(!recipe_id){
      res.status(400).json({
        message: "recipe_id is missing"
      })
      return
    }

    const { title, category, difficulty, portion, minute_duration } = req.body

    try {
      const { rowCount } = await pool.query("UPDATE recipes SET title = $1, category = $2, difficulty = $3, portion = $4, minute_duration = $5 WHERE id = $6 AND author_id = $7", [title, category, difficulty, portion, minute_duration, recipe_id, userId])

      res.json({
        message: `recipe with id ${recipe_id} is updated`,
        rowCount
      })
    } catch (e) {
      res.status(500).json({
        message: e.message
      })
    }
  }
}


function deleteRecipe(pool){
  return async (req, res) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    if(!recipe_id){
      res.status(400).json({
        message: "recipe_id is missing"
      })
      return
    }

    try {
      const { rowCount, rows } = await pool.query("DELETE FROM recipes WHERE id = $1 AND author_id = $2 RETURNING image_path", [recipe_id, userId])

      if(rowCount != 0)
        await recipeService.remove(rows[0].image_path)

      res.json({
        message: "requested operation completed",
        rowCount
      })
    } catch (e) {
      res.status(500).json({
        message: e.message
      })
    }
  }
}

module.exports = {
  postRecipe,
  putRecipe,
  deleteRecipe
}