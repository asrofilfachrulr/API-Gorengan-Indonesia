const multer = require("multer")
const {nanoid} = require("nanoid")

const upload = multer({
  storage: multer.diskStorage({
    destination: 'uploads/user/',
    filename: function(req, file, next) {
      next(null, `${nanoid()}.${Date.now()}`)
    }
  })
})

module.exports = upload