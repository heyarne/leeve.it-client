var app = require('ampersand-app')
var Router = require('ampersand-router')

module.exports = Router.extend({
  routes: {
    '': 'home',

    'notes/create/:lat/:lng': 'createNote'
  },

  home: function () {
    // if (!app.isLoggedIn()) {
    //   app.router.redirectTo('login')
    // }
  },

  login: function () {
    // console.log('This is the login screen')
  },

  createNote: function (lat, lng) {
    app.trigger('notes:create', [lat, lng])
  }
})
