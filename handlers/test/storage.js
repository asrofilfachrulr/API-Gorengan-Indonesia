const { uploadTestService } = require(`../../services/supabase/storage/uploadTest`)

async function testUploadImg(req, res){
  try {
    const data = await uploadTestService();
    console.log(data)
    res.json({
      data,
      file_url: process.env.STORAGE_URL_PREFIX + data.fullPath
    });
  } catch(e){
    res.status(500).json({
      error: e
    })
  }
}

module.exports = {
  testUploadImg
}