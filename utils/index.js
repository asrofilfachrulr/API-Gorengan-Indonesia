const isEmptyString = (str) => {
  const pattern = /^\s+$/g
  return pattern.test(str) || str === ''
}

const fileDateFormat = (date) => {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  const seconds = String(date.getSeconds()).padStart(2, '0');

  return `${year}${month}${day}_${hours}:${minutes}:${seconds}`;
}

module.exports = {
  fileDateFormat,

}