const isEmptyString = (str) => {
  const pattern = /^\s+$/g
  return pattern.test(str) || str === ''
}

module.exports = {
  isEmptyString
}