/* globals localStorage */
'use strict'

const LOCALSTORAGE_IDENTIFIER = '__keyPair__'

var openpgp = require('openpgp')

/**
 * A thin wrapper around openpgpjs, used for en- and decrypting notes
 *
 * @type {[type]}
 */
module.exports = class Crypto {

  /**
   * Loads keypair from localstorage if there is one, if not it generates it and
   * persists it to localstorage for re-use
   *
   * @contructor
   */
  constructor (options) {
    if (!options.passphrase) {
      throw new Error('No passphrase given')
    }

    var localKeyPair = localStorage.getItem(LOCALSTORAGE_IDENTIFIER)
    var keyPair = localKeyPair ? JSON.stringify(localKeyPair) : null

    this._passphrase = options.passphrase

    if (keyPair) {
      this._keyPair = keyPair
    } else {
      if (!options.userId) {
        throw new Error('No User ID given for the public key')
      }

      console.log('Generating keypair')

      openpgp.generateKeyPair(options)
        .then(keyPair => {
          console.log('keypair generated', arguments)
          this._keyPair = {
            privateKeyArmored: keyPair.privateKeyArmored,
            publicKeyArmored: keyPair.publicKeyArmored
          }

          localStorage.setItem(LOCALSTORAGE_IDENTIFIER, JSON.stringify(this._keyPair))
        })
        .catch(err => console.error('Failed generating the keyPair', err))
    }
  }

  /**
   * Encrypt a message asynchronously
   *
   * @param  {String} message   The plain text message to encrypt
   * @return {Promise}
   */
  encrypt (message) {
    var publicKey = openpgp.key.readArmored(this._keyPair.publicKeyArmored)

    return openpgp.encryptMessage(publicKey.keys, message)
  }

  /**
   * Decrypt a message asynchronously
   *
   * @param  {string} message The OpenPGP-encrypted message
   * @return {Promise}
   */
  decrypt (message) {
    var privateKey = openpgp.key.readArmored(this._keyPair.privateKeyArmored)
    privateKey.decrypt(this.passphrase)

    return openpgp.decryptMessage(privateKey, message)
  }

}
