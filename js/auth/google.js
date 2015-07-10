'use strict'

var _url = require('../helpers')._url

function googleAuthSuccess (googleUser) {
  var profile = googleUser.getBasicProfile()

  console.log('Success! :)')
  console.log(googleUser, profile)

  var requestBody = new FormData()
  requestBody.append('idtoken', googleUser.id_token)

  fetch(_url('auth/google/verify'), {
    method: 'post',
    body: requestBody
  }).then(function (res) {
    console.log(response)
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
