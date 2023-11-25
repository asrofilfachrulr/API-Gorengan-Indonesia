function postFavourite(pool) {
  return async(req, res) => {
    const { userId } = req.user
    const { recipe_id } = req.params

    try {
      await pool.query("INSERT INTO favourites (user_id, recipe_id) VALUES ($1, $2)", [userId, recipe_id])

      res.status(201).json({
        message: "favourite created"
      })
    } catch (e) {
      res.status(500).json({
        error: 'ServerError',
        message: e.message
      })
    }
  }
}

function deleteFavourite(pool) {
  return async(req, res) => {
    const { userId } = req.user
    const { recipe_id } =  req.params

    try {
      await pool.query("DELETE FROM favourites WHERE user_id = $1 AND recipe_id = $2", [userId, recipe_id])

      res.status(200).json({
        message: "favourite deleted"
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
  postFavourite,
  deleteFavourite
}