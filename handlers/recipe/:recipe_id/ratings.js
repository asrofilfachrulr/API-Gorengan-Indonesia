function getRatingsByRecipeId(pool){
  return async(req, res) => {
    const { recipe_id } = req.params;
    const { order_by } = req.query;
  
    let queryText = 'SELECT u.username, u.id, u.thumb_url, r.stars, r.comment, r.date FROM ratings r JOIN users u ON r.user_id = u.id WHERE r.recipe_id = $1';

    if(order_by == 'date') {
      queryText += ' ORDER BY DATE DESC'
    }

    try {
      const { rows } = await pool.query(queryText, [recipe_id]);
      
      if(rows.length > 0){
        res.status(200).json({
          message: 'success',
          data: rows
        })
      } else {
        res.status(404).json({message: `ratings data is not found for recipe_id: ${recipe_id}`, data: []})
      }
    } catch (error) {
      res.status(500).json({
        error: 'ServerError',
        message: error.message
      })
    }
  }
}

function postRatingByRecipeId(pool) {
  return async (req, res) => {
    const { userId } = req.user
    const { stars, comment } = req.body
    const { recipe_id } = req.params

    if(typeof stars !== "number"){
      res.status(400).json({
        message: "ClientError",
        error: "star must be number type"
      })
    }

    try {
      await pool.query("INSERT INTO ratings(user_id, stars, comment, recipe_id, date) VALUES ($1, $2, $3, $4, $5)", [userId, stars, comment, recipe_id, new Date()])

      res.status(201).json({
        message: 'rating created'
      })
    } catch(e){
      res.status(500).json({
        error: 'ServerError',
        message: e.message
      })
    }
  }
}

function putRatingByRecipeId(pool){
  return async (req, res) => {
    const { userId } = req.user
    const { stars, comment } = req.body
    const { recipe_id } = req.params

    try {
      await pool.query("UPDATE ratings SET stars = $1, comment = $2, date = $3 WHERE recipe_id = $4 AND user_id = $5", [stars, comment, new Date(), recipe_id, userId])

      res.status(200).json({
        message: 'rating updated'
      })
    } catch(e){
      res.status(500).json({
        error: 'ServerError',
        message: e.message
      })
    }
  }
}

function deleteRatingByRecipeId(pool){
  return async(req, res) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    try {
      await pool.query("DELETE FROM ratings WHERE user_id = $1 AND recipe_id = $2", [userId, recipe_id])

      res.status(200).json({
        message: 'rating deleted'
      })
    } catch (e) {
      res.status(500).json({
        error: 'ServerError',
        message: e.message
      })
    }
  }
}

module.exports = {
  getRatingsByRecipeId,
  postRatingByRecipeId,
  putRatingByRecipeId,
  deleteRatingByRecipeId
}