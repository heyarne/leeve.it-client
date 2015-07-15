var EncryptedMessage = require('./encrypted-message')
var _url = require('../helpers')._url

module.exports = EncryptedMessage.extend({

  urlRoot: _url('/notes'),

  props: {
    content: 'string',
    latLng: 'array'
  }

})
