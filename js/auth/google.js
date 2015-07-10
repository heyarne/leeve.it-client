'use strict'

function googleAuthSuccess () {
  console.log('Success! :)')
  console.log(arguments)
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
