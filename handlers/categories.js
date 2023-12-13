function getCategories(pool){
  return async (req, res) => {
    try {
      const { rows } = await pool.query("SELECT distinct LOWER(category) AS category FROM recipes")

      res.json({
        message: "success retrieved categories",
        data: rows.map(it => it.category)
      })
    } catch (e){
      res.status(500).json({
        message: e.message
      })
    }
  }
}

module.exports = {
  getCategories
}
