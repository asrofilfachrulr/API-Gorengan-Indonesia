function uploadFile(service){
  return async (req, res, next) => {
    const file = req.file

    if(!file){
      res.status(400).json({
        message: "no file uploaded"
      })
      return
    }

    try {
      const data = await service.upload(file.originalname, file.buffer)
      req.uploadedData = data
      next()
    } catch(e) {
      res.status(parseInt(e.statusCode)).json({
        message: e.message,
        error: e.error
      })
    }
  }
}

function uploadOptionalFile(service) {
  return async (req, res, next) => {
    const file = req.file
    if(file) {
      await uploadFile(service)(req, res, next)
    } else next()
  }
}

module.exports = {
  uploadFile,
  uploadOptionalFile
}