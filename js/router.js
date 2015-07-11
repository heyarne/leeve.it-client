var app = require('ampersand-app')
var Router = require('ampersand-router')

module.exports = Router.extend({
  routes: {
    '': 'home',
    'login': 'login'
  },

  home: function () {
    if (!app.me || !app.me.signedIn()) {
      app.router.redirectTo('login')
    }
  },

  login: function () {
    console.log('This is the login screen')
  }
})
