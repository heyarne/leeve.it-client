var Collection = require('ampersand-collection')
var Note = require('../models/note')

var _url = require('../helpers')._url

module.exports = Collection.extend({

  urlRoot: _url('/notes/me'),

  model: Note

})
