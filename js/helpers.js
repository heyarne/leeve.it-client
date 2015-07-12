var config = require('./config')
module.exports = {

  /**
   * Converts an API url path to a complete URL with protocol and version etc
   * @param  {String} url
   * @return {String}
   */
  _url: function _url (url) {
    if (url[0] === '/') url = url.substr(1)

    return config.serverUrl + url
  }

}
