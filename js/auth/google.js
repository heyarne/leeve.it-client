/* globals fetch */
'use strict'

var _url = require('../helpers')._url

function googleAuthSuccess (googleUser) {
  console.log('Successfully authenticated using google! :)')
  var response = googleUser.getAuthResponse()

  fetch(_url('auth/google/verify'), {
    method: 'post',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      idtoken: response.id_token
    })
  }).then(function (res) {
    console.log('Token verified')
    console.log(res)
  }).catch(function (err) {
    console.error('Could not verify the OpenID JWT')
    console.error(err.message)
  })
}

function googleAuthFailure () {
  console.error('Oh nose :(')
  console.log(arguments)
}

module.exports = {

  /**
   * Builds the google auth button and attaches it to the dom
   * @param  {String|jQuery} loginButtonContainer
   */
  setup: function setupGoogleAuth () {
    window.googleAuthSuccess = googleAuthSuccess
    window.googleAuthFailure = googleAuthFailure
  }

}
