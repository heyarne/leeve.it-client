var Model = require('ampersand-model')

module.exports = Model.extend({

  props: {
    alias: 'string',
    picture: 'string',
    keyIdentifier: 'string'
  },

  session: {
    signedIn: 'boolean'
  }

})
