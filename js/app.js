'use strict'

require('./tags/app.tag')
var riot = require('riot')

var app = require('ampersand-app')
var Router = require('./router')

app.extend({

  init: function () {
    this.initUI()
    this.initRouter()
  },

  initUI: function () {
    riot.mount('*')
  },

  router: new Router(),
  initRouter: function () {
    this.router.history.start({ pushState: false })
  }

})

app.init()
