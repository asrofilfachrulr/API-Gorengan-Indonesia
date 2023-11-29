function getAllFavourites(pool){
  return async(req, res) => {
    const { userId } = req.user
    
    try {
      const { rows } = await pool.query("SELECT recipe_id FROM favourites WHERE user_id = $1", [userId])

      if(rows.length > 0)
        res.status(200).json({
          message: 'success',
          data: rows.map(row => row["recipe_id"])
        })
      else
        res.status(404).json({
          message: `favourites data is not found for user_id: ${userId}`,
          data: []
      })
    } catch (e) {
      res.status(500).json({
        error: 'ServerError',
        message: error.message
      })
    }
  }
}

module.exports = {
  getAllFavourites
}