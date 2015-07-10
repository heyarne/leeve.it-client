'use strict'
var _url = require('./helpers')._url

var config = require('./config')
var map = require('./map')

var auth = {
  google: require('./auth/google')
}

;(function init () {
  auth.google.setup('#login-buttons')
  map('map-container')
})()
