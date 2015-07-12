var BaseModel = require('./base-model')
var _url = require('../helpers')._url

module.exports = BaseModel.extend({

  urlRoot: _url('/users/me'),

  props: {
    alias: 'string',
    picture: 'string',
    keyIdentifier: 'string'
  }

})
