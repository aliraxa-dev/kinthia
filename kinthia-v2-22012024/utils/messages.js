const moment = require('moment');

function formatMessage(name, type, image, text) {
  return {
    name,
    type,
    image,
    text,
    date: moment().format('DD-MM-YYYY'),
    time: moment().format('h:mm a')
  };
}

module.exports = formatMessage;
