<map>
    <div id="map-container"></div>

    <script>
        var L = require('leaflet')
        // the path to the leaflet images folder
        L.Icon.Default.imagePath = '/node_modules/leaflet/dist/images/'

        /**
         * Constructs a Leaflet map int the given container
         * @param {String} containerId
         */
        function init () {
          var map = L.map('map-container', {
            scrollWheelZoom: false
          })

          L.tileLayer('http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, Tiles courtesy of <a href="http://hot.openstreetmap.org/" target="_blank">Humanitarian OpenStreetMap Team</a>'
          }).addTo(map)

          // center the map on berlin
          map.setView([52.520007, 13.404954], 11)
        }

        this.on('mount', init)
    </script>
</map>
