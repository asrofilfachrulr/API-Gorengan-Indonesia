function getStepsByRecipeId(pool){
  return async (req, res) => {
    const { recipe_id } = req.params;

    if(!recipe_id){
      res.status(400).json({message: "bad request: missing recipe_id"})
      return
    }

    try {
      const { rows } = await pool.query('SELECT * FROM steps WHERE recipe_id = $1', [recipe_id]);
      if(rows.length > 0){
        res.json({
          message: 'success',
          data: rows
        })
      } else {
        res.status(404).json({message: `steps data is not found for recipe_id: ${recipe_id}`})
      }
    } catch (error) {

    }
  }
}

module.exports = {
  getStepsByRecipeId
}