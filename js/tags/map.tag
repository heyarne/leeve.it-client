require('./note-form/note-form.tag')

<map>
    <div id="map-container"></div>

    <script>
        var app = require('ampersand-app')
        var riot = require('riot')
        var L = require('leaflet')
        // the path to the leaflet images folder
        L.Icon.Default.imagePath = '/node_modules/leaflet/dist/images/'

        var map

        /**
         * Constructs a Leaflet map int the given container
         * @param {String} containerId
         */
        this.init = () => {
          map = L.map('map-container', {
            scrollWheelZoom: true,
            doubleClickZoom: false
          })

          L.tileLayer('http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, Tiles courtesy of <a href="http://hot.openstreetmap.org/" target="_blank">Humanitarian OpenStreetMap Team</a>'
          }).addTo(map)

          this.bindMapEvents()

          map.setZoom(11)

          if (!window.location.hash) {
            map.locate()
          }
        }

        this.bindMapEvents = () => {
            // Fired when a user is located using the geolocation API
            map.on('locationfound', (event) => {
                map.panTo(event.latlng)
            })

            map.on('dblclick', function (event) {
                var { lat, lng } = event.latlng
                app.navigate(`notes/create/${lat}/${lng}`)
            })
        }

        this.createNote = (latLng) => {
            var noteCreationElem = document.createElement('div')
            riot.mount(noteCreationElem, 'note-form')

            map.panTo(latLng)
            map.openPopup(noteCreationElem, latLng)
        }

        this.on('mount', this.init)
        app.on('notes:create', this.createNote)
    </script>
</map>
