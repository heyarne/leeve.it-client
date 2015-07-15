var BaseModel = require('./base-model')

module.exports = BaseModel.extend({

  /**
   * This model overrides the sync method to do en- and decryption when fetching
   * the messages from the server, so the decrypted version is only ever
   * available on the client side.
   */
  sync (method, model, opts) {
    console.log('sync called')
    console.log('this:  ', this)
    console.log('model: ', model)

    BaseModel.prototype.sync.apply(this, arguments)
  }

})
