function getRatingsByRecipeId(pool){
  return async(req, res) => {
    const { recipe_id } = req.params;
    const { order_by } = req.query;

    if(!recipe_id){
      res.status(400).json({message: "bad request: missing recipe_id"})
      return;
    }
    
    let queryText = 'SELECT u.username, u.image_url, r.stars, r.like_count, r.comment, r.date FROM ratings r JOIN users u ON r.user_id = u.id WHERE r.recipe_id = $1';

    if(order_by == 'date') {
      queryText += ' ORDER BY DATE DESC'
    } else if (order_by == 'like_count') {
      queryText += ' ORDER BY like_count DESC'
    }

    try {
      const { rows } = await pool.query(queryText, [recipe_id]);
      
      if(rows.length > 0){
        res.json({
          message: 'success',
          data: rows
        })
      } else {
        res.status(404).json({message: `ratings data is not found for recipe_id: ${recipe_id}`})
      }
    } catch (error) {
      res.status(500).json({
        error: 'ServerError',
        message: error.message
      })
    }
  }
}

module.exports = {
  getRatingsByRecipeId
}