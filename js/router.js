var app = require('ampersand-app')
var Router = require('ampersand-router')

module.exports = Router.extend({
  routes: {
    '': 'home',

    'notes/create/:lat/:lng': 'createNote'
  },

  home () {
    app.trigger('home')
  },

  createNote (lat, lng) {
    app.trigger('notes:create', [lat, lng])
  }
})
