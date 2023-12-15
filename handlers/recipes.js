function getAllRecipes(pool) {
  return async (req, res) => {
    const { limit } = req.query

    const query = `
      SELECT 
      r.id as id, 
      u.username as username,
      r.title as title,
      r.category as category,
      r.img_url as img_url,
      r.difficulty as difficulty,
      r.portion as portion,
      r.minute_duration as minute_duration,
      r.stars as stars,
      r.view_count as view_count,
      u.image_url as image_url
      FROM recipes r JOIN users u
      ON r.author_id = u.id
      ${limit ? `LIMIT ${limit}`: ''};
    `
    try {
      const { rows } = await pool.query(query);

      if(rows.length > 0){
        res.json({
          message: 'success',
          data: rows
        })
      } else {
        res.json({
          message: 'null data',
          data: []
        })
      }
    } catch (error){
      res.status(500).json({message: "Server Error: " + error.message})
    }
  }
}

module.exports = {
  getAllRecipes
}