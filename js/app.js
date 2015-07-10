'use strict'

var app = require('ampersand-app')

var map = require('./map')
var auth = {
  google: require('./auth/google')
}

app.extend({
  init: function init () {
    auth.google.setup('#login-buttons')
    map('map-container')
  }
})

app.init()
