var BaseModel = require('./base-model')
var _url = require('../helpers')._url

module.exports = BaseModel.extend({

  urlRoot: _url('/notes'),

  props: {
    content: 'string',
    location: 'array'
  }

})
