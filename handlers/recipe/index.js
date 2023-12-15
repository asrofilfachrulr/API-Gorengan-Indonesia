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

    let jsonData
    let client

    try {
      console.log(`req.body = ${JSON.stringify(req.body)}`);
      
      jsonData = JSON.parse(req.body.json)
  
      const { title, category, difficulty, portion, minute_duration, ingredients, steps } = jsonData

      client = await pool.connect()

      // id, author_id, title, category, image_url, difficulty, portion, minute_duration, stars, image_path
      const recipeQuery = "INSERT INTO recipes VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)"
      const recipeParams = [recipeId, userId, title, category.toLowerCase(), imageUrl, difficulty.toLowerCase(), portion, minute_duration, 0, imagePath]

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
        if (!it.hasOwnProperty("qty") || !it.hasOwnProperty("unit") || !it.name)
          throw new Error("missing required attribute(s)!")
        return [it.qty, it.unit, it.name]
      }))

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

      await client.query("BEGIN")

      await client.query(recipeQuery, recipeParams)
      
      await Promise.all([
        client.query(ingredientsQuery, ingredientsParams),
        client.query(stepsQuery, stepsParams)
      ])

      await client.query("COMMIT")

      const { rows } = await pool.query("SELECT * FROM recipes WHERE id = $1", [recipeId])

      res.status(201).json({
        message: "recipe created",
        data: rows
      })
    } catch (e) {
      await Promise.all([
        client.query("ROLLBACK"),
        recipeService.remove(imagePath)
      ])

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

    if (!recipe_id) {
      res.status(400).json({
        message: "recipe_id is missing"
      })
      return
    }

    const data = req.uploadedData
    let imagePath, imageUrl

    if(data){
      imagePath = data.path;
      imageUrl = `${process.env.SUPABASE_STORAGE_URL_PREFIX}${data.fullPath}`;
    }

    
    let client
    let jsonData

    try {
      jsonData = JSON.parse(req.body.json)
  
      const { title, category, difficulty, portion, minute_duration, ingredients, steps } = jsonData

      client = await pool.connect()
      
      /*
      *   Updating Recipe on recipes Table
      */

      let recipeQuery = `
        WITH OldRecipe AS (
          SELECT image_path as old_image_path
          FROM recipes
          WHERE id = $1
        )
        UPDATE recipes SET
          title = $2,
          category = $3,
          difficulty = $4,
          portion = $5,
          minute_duration = $6
          ${imageUrl ? 
            `, img_url = $7, 
              image_path = $8` 
          : ''}
          WHERE id = $1
      `

      let recipeParams = [recipe_id, title, category, difficulty, portion, minute_duration]

      if(imageUrl){
        recipeQuery += ` AND author_id = $9 `
        recipeParams.push(imageUrl, imagePath)
      } else {
        recipeQuery += ` AND author_id = $7 `
      }

      // either case, push param at the end
      recipeParams.push(userId)

      recipeQuery += "RETURNING (SELECT old_image_path FROM OldRecipe) AS old_path"

      /*
      *   Updating Ingredients
      */

      const deleteIngredientsQuery = `
      DELETE FROM ingredients 
      WHERE 
        recipe_id = $1 AND 
        (SELECT author_id FROM recipes WHERE id = $1) = $2
      `
      const deleteIngredientsParams = [recipe_id, userId]

      let ingredientsQuery = "INSERT INTO ingredients VALUES "
      
      let placeholder = 1
      for (let i = 0; i < ingredients.length; i++) {
        ingredientsQuery += `($1, $${++placeholder}, $${++placeholder}, $${++placeholder})`

        if (i < ingredients.length - 1)
          ingredientsQuery += ", "
      }

      const ingredientsParams = [recipe_id]
      ingredientsParams.push(...ingredients.flatMap(it => {
        if (!it.hasOwnProperty("qty") || !it.hasOwnProperty("unit") || !it.name)
          throw new Error("missing required attribute(s)!")
        return [it.qty, it.unit, it.name]
      }))
      
      /*
      *   Updating Steps
      */

      const deleteStepsQuery = `
      DELETE FROM STEPS
      WHERE
        recipe_id = $1 AND
        (SELECT author_id FROM recipes WHERE id = $1) = $2`

      const deleteStepsParams = [recipe_id, userId]
      
      let stepsQuery = "INSERT INTO steps VALUES "

      placeholder = 1
      for (let i = 0; i < steps.length; i++) {
        stepsQuery += `($1, $${++placeholder}, $${++placeholder})`

        if (i < steps.length - 1)
          stepsQuery += ", "
      }

      const stepsParams = [recipe_id]
      stepsParams.push(...steps.flatMap(it => {
        if (!it.number || !it.step)
          throw new Error("missing required attribute(s)!")
        return [it.number, it.step]
      }))

      /*
      * SQL Execution
      */
      await client.query("BEGIN")
      
      // recipe
      const recipeResult = await client.query(recipeQuery, recipeParams)
      if(recipeResult.rowCount == 0)
        throw new Error("Failed to update recipe")

      const { old_path : oldPath } = recipeResult.rows[0]
      if(!oldPath)
        throw new Error("Failed retrieving old data")

      // ingredients
      await client.query(deleteIngredientsQuery, deleteIngredientsParams)

      const ingredientsResult = await client.query(ingredientsQuery, ingredientsParams)
      if(ingredientsResult.rowCount < ingredients.length && ingredients.length > 0)
        throw new Error(`Failed to update ingredients; rc: ${ingredientsResult.rowCount} out of ${ingredients.length}`)

      // steps
      await client.query(deleteStepsQuery, deleteStepsParams)

      const stepsResult = await client.query(stepsQuery, stepsParams)
      if(stepsResult.rowCount < steps.length && steps.length > 0)
        throw new Error(`Failed to update steps; rc: ${stepsResult.rowCount} out of ${steps.length}`)

      await client.query("COMMIT")

      if(data)
        await recipeService.remove(oldPath)

      res.json({
        message: "success updating recipe",
        rowCount:{
          "recipes": recipeResult.rowCount,
          "ingredients": ingredientsResult.rowCount,
          "steps": stepsResult.rowCount
        }
      })

    } catch (e) {
      const promises = []
      if(client)
        promises.push(client.query("ROLLBACK"))

      if(data)
        promises.push(recipeService.remove(imagePath))

      await Promise.all(promises)

      res.status(500).json({
        message: e.message,
        body: jsonData 
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

function addViewCount(pool){
  return async (req, res) => {
    const { recipe_id } = req.params
    try {
      await pool.query("UPDATE recipes SET view_count = view_count + 1 WHERE id = $1", [recipe_id])

      res.json({
        message: "success"
      })
    } catch (e){
      res.status(500).json({
        message: e.message
      })
    }
  }
}

function getViewCount(pool){
  return async (req, res) => {
    const { recipe_id } = req. params
    try {
      const {rows} = await pool.query("SELECT view_count FROM recipes WHERE id = $1", [recipe_id]);

      res.json({
        message: "success",
        data: {
          view_count: rows.length > 0 ? rows[0].view_count : 0
        }
      })
    } catch (e){
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
  putRecipeImage,
  addViewCount,
  getViewCount
}
