// polyfills
window.Promise = window.Promise || require('es6-promise').Promise
window.fetch = window.fetch || require('fetch-ponyfill')()

// fun!
var config = require('./config')
var map = require('./map')

function _url (url) {
  return config.serverUrl + url
}

function getAuthProviders () {
  console.log('Getting auth providers at ' + _url('auth/providers'))
  fetch(_url('auth/providers'))
    .then(function () {
      console.log(arguments)
    })
    .catch(function () {
      console.error('Something went wrong', arguments)
    })
}

(function init () {
  map('map-container')
  getAuthProviders()
})()
