const { nanoid } = require("nanoid")
const recipeService = require("../../services/supabase/storage/recipe")

function getRecipeById(pool) {
  return async (req, res) => {
    const { recipe_id } = req.params
    if (!recipe_id) {
      res.status(404).json({
        message: "recipe_id is missing"
      })
      return
    }

    try {
      const { rows } = await pool.query("SELECT * FROM recipes WHERE id = $1", [recipe_id])

      if (rows.length == 0) {
        res.json({
          message: "recipe not found",
          data: []
        })

        return
      }

      res.json({
        message: "success retrieved recipe data",
        data: rows[0]
      })
    } catch (e) {
      res.status(500).json({
        message: e.message
      })
    }
  }
}

function postRecipe(pool) {
  return async (req, res) => {
    const { userId } = req.user
    const data = req.uploadedData

    if (!data)
      throw new Error("Middleware error")


    const imagePath = data.path;
    const imageUrl = `${process.env.SUPABASE_STORAGE_URL_PREFIX}${data.fullPath}`;
    const recipeId = `recipe-${nanoid(16)}`

    console.log(`req.body = ${JSON.stringify(req.body)}`);
    
    const jsonData = JSON.parse(req.body.json)

    const { title, category, difficulty, portion, minute_duration, ingredients, steps } = jsonData

    try {
      // id, author_id, title, category, image_url, difficulty, portion, minute_duration, stars, image_path
      await pool.query("INSERT INTO recipes VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)",
        [recipeId, userId, title, category.toLowerCase(), imageUrl, difficulty.toLowerCase(), portion, minute_duration, 0, imagePath]
      )

      // recipe_id, qty, unit, name
      let ingredientsQuery = "INSERT INTO ingredients VALUES "

      let placeholder = 1
      for (let i = 0; i < ingredients.length; i++) {
        ingredientsQuery += `($1, $${++placeholder}, $${++placeholder}, $${++placeholder})`

        if (i < ingredients.length - 1)
          ingredientsQuery += ", "
      }

      const ingredientsParams = [recipeId]
      ingredientsParams.push(...ingredients.flatMap(it => {
        if (!it.qty || !it.unit || !it.name)
          throw new Error("missing required attribute(s)!")
        return [it.qty, it.unit, it.name]
      }))

      await pool.query(ingredientsQuery, ingredientsParams)

      // recipe_id, number, step
      let stepsQuery = "INSERT INTO steps VALUES "

      placeholder = 1
      for (let i = 0; i < steps.length; i++) {
        stepsQuery += `($1, $${++placeholder}, $${++placeholder})`

        if (i < steps.length - 1)
          stepsQuery += ", "
      }

      const stepsParams = [recipeId]
      stepsParams.push(...steps.flatMap(it => {
        if (!it.number || !it.step)
          throw new Error("missing required attribute(s)!")
        return [it.number, it.step]
      }))

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

function putRecipe(pool) {
  return async (req, res) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    if (!recipe_id) {
      res.status(400).json({
        message: "recipe_id is missing"
      })
      return
    }

    const { title, category, difficulty, portion, minute_duration } = req.body

    try {
      const { rowCount } = await pool.query("UPDATE recipes SET title = $1, category = $2, difficulty = $3, portion = $4, minute_duration = $5 WHERE id = $6 AND author_id = $7", [title, category.toLowerCase(), difficulty.toLowerCase(), portion, minute_duration, recipe_id, userId])

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


function deleteRecipe(pool) {
  return async (req, res) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    if (!recipe_id) {
      res.status(400).json({
        message: "recipe_id is missing"
      })
      return
    }

    try {
      const { rowCount, rows } = await pool.query("DELETE FROM recipes WHERE id = $1 AND author_id = $2 RETURNING image_path", [recipe_id, userId])

      if (rowCount != 0)
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

function putRecipeImage(pool) {
  return async (req, res) => {
    let imagePath
    
    try {
      const { userId } = req.user
      const data  = req.uploadedData

      if (!data)
        throw new Error("middleware error")

      const { recipe_id } = req.params

      // handled on middleware recipe authorization
      // if (!recipe_id)
      //   throw new Error("missing recipe_id")

      const { prev_path } = req.query

      if (!prev_path)
        throw new Error("prev_path is missing")

      imagePath = data.path;
      const imageUrl = `${process.env.SUPABASE_STORAGE_URL_PREFIX}${data.fullPath}`;

      const { rowCount } = await pool.query("UPDATE recipes SET img_url = $1, image_path = $2 WHERE author_id = $3 AND id = $4", [imageUrl, imagePath, userId, recipe_id])

      if(rowCount != 0)
        await recipeService.remove(prev_path)

      res.json({
        message: "recipe's image is updated",
        rowCount
      })
    } catch (e) {
      await recipeService.remove(imagePath)
      res.status(500).json({
        message: e.message
      })
    }
  }
}

module.exports = {
  postRecipe,
  putRecipe,
  deleteRecipe,
  getRecipeById,
  putRecipeImage
}
