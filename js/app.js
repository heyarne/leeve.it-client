'use strict'

require('./tags/app.tag')
var riot = require('riot')

var app = require('ampersand-app')
var Router = require('./router')

var Me = require('./models/me')

app.extend({

  init: function () {
    this.initUI()
    this.initRouter()
  },

  initUI: function () {
    this.tags = riot.mount('*')
  },

  router: new Router(),
  initRouter: function () {
    this.router.history.start({ pushState: false })
  },

  navigate: function (page) {
    var url = (page.charAt(0) === '/') ? page.slice(1) : page
    this.router.history.navigate(url, { trigger: true })
  },

  isLoggedIn: function () {
    return !!this.me
  }

})

// the auth event indicates that we successfully authentified against the server,
// having established a session cookie that we can use to further request
// sensbile data.
app.on('auth', function () {
  new Me().fetch({
    success: function (me) {
      app.me = me
      app.trigger('login', me)
    },
    error: function () {
      console.log('Unable to fetch me', arguments)
    }
  })
})

app.on('logout', function () {
  app.me = null
})

// expose for debugging:
window.app = app

app.init()
