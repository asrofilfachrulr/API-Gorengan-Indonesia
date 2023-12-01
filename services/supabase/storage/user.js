const supabase = require('../../../config/supabase')
const fs = require("fs")
const {nanoid} = require("nanoid")
const {fileDateFormat} = require("../../../utils")
const mime = require('mime-types');

const STORAGE_NAME = process.env.SUPABASE_STORAGE_NAME

async function upload(fileName, fileData){
  const ext = fileName.match(/\.(\S{2,})$/)[0]
  const uploadFileName = `${fileDateFormat(new Date())}__${nanoid(5)}${ext}`
  const contentType = mime.contentType(fileName)

  const {data, error} = await supabase
      .storage
      .from(STORAGE_NAME)
      .upload(`user/${uploadFileName}`, fileData, {
        cacheControl: '6000',
        upsert: false,
        contentType: contentType || 'image/jpeg'
      })

  if(error != null)
    throw error

  return data
}

async function remove(imagePath){
  const {data, error} =  await supabase
      .storage
      .from(STORAGE_NAME)
      .remove([imagePath])

  if(error != null)
    throw error

    return data
}

module.exports = {
  upload,
  remove
}