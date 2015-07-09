var config = require('./config')
var map = require('./map')

function _url (url) {
  return config.serverUrl + url
}

function getAuthProviders () {
  console.log('Getting auth providers at ' + _url('auth/providers'))
  $.getJSON(_url('auth/providers'))
    .then(function () {
      console.log(arguments)
    })
}

(function init () {
  map('map-container')
  getAuthProviders()
})()
