var config = require('./config')
var map = require('./map')

console.log('Server is available at ' + config.serverUrl)

var mapInstance = map.init('map')
console.log(mapInstance)
