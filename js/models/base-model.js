var Model = require('ampersand-model')

/**
 * BaseModel to be used against the MongoDB API. Makes sure that the cookies get
 * sent with the according requests (for authorization) and maps the idAttribute
 * to the internal one used by MongoDB.
 *
 * @type {BaseModel}
 */
module.exports = Model.extend({

  ajaxConfig: {
    xhrFields: {
      withCredentials: true
    }
  },

  idAttribute: '_id'

})
