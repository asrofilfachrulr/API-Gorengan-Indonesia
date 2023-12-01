const supabase = require('../../../config/supabase')
const fs = require("fs")
const {nanoid} = require("nanoid")
const {fileDateFormat} = require("../../../utils")

async function uploadTestService(){
  const fileName = "test_img.png"
  const ext = fileName.match(/\.(\S{2,})$/)
  const path = `${__dirname}/${fileName}`
  const fileData = fs.readFileSync(path)

  const uploadFileName = `${fileDateFormat(new Date())}__${nanoid(10)}${ext[0]}`

  const result = await supabase
    .storage
    .from(process.env.STORAGE_NAME)
    .upload(`default/${uploadFileName}`, fileData)

    const {data, error} = result

    if(error != null)
      throw error

    console.log(result)
    
    return data
}

module.exports = {
  uploadTestService
}