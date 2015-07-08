/* globals $, */

(function (App) {
  window.App = App

  var _url = function (url) {
    return App.config.serverUrl + url
  }

  App.init = function () {
    App.getAuthProviders()
  }

  App.getAuthProviders = function getAuthProviders () {
    console.log('Getting auth providers at ' + _url('auth/providers'))
    $.getJSON(_url('auth/providers'))
      .then(function () {
        console.log(arguments)
      })
  }
})(window.App || {})
