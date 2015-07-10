'use strict'

// fun!
var config = require('./config')
var map = require('./map')

var auth = {
  google: require('./auth/google')
}

function _url (url) {
  return config.serverUrl + url
}

function getAuthProviders () {
  console.log('Getting auth providers at ' + _url('auth/providers'))
  fetch(_url('auth/providers'))
    .then(function (response) {
      return response.json()
    })
    .then(function () {
      console.log(arguments)
    })
    .catch(function () {
      console.error('Something went wrong')
      console.log(arguments)
    })
}

console.log('Was geht ab?')

(function init () {
  auth.google.setup('#login-buttons')
  map('map-container')
  getAuthProviders()
})()
