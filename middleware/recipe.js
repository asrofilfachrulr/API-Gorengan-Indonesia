function recipeAuthorization(pool){
  return async (req, res, next) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    if(!recipe_id){
      return res.status(400).json({
        message: "missing recipe_id"
      })
    }

    try {
      const { rows } = await pool.query("SELECT * FROM recipes WHERE author_id = $1 AND id = $2", [userId, recipe_id])

      if(rows.length == 0){
        res.status(404).json({
          message: "You are not allowed to access this resource"
        })
      } else {
        next()
      } 
    } catch (e) {
      res.status(500).json({
        message: e.message
      })
    }
  }
}

module.exports = {
  recipeAuthorization,
}