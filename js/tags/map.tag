require('./note-form/note-form.tag')
require('./note/note.tag')

<map>
    <div id="map-container"></div>

    <script>
        var app = require('ampersand-app')
        var riot = require('riot')
        var L = require('leaflet')
        // the path to the leaflet images folder
        L.Icon.Default.imagePath = '/node_modules/leaflet/dist/images'

        var popup = L.popup()
        var markers = []
        var map

        /**
         * Constructs a Leaflet map int the given container
         * @param {String} containerId
         */
        init () {
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

        /**
         * Sets up the events for interacting with the map (centering it when a
         * user's location is found, creating the form on doubleclick etc.)
         */
        bindMapEvents () {
            // Fired when a user is located using the geolocation API
            map.on('locationfound', (event) => {
                map.panTo(event.latlng)
            })

            // set up the url for the creation form to be opened at a specific place
            map.on('dblclick', (event) => {
                var { lat, lng } = event.latlng
                app.navigate(`notes/create/${lat}/${lng}`)
            })

            // navigate back home when the creation form is closed
            map.on('popupclose', () => window.location.hash && app.navigate(''))
        }

        /**
         * Sets up the note creation form
         * @param  {LatLng} latLng
         */
        createNote (latLng) {
            var noteCreationElem = document.createElement('div')
            riot.mount(noteCreationElem, 'note-form', { latLng: latLng })

            map.panTo(latLng)
            map.openPopup(noteCreationElem, latLng)
        }

        showNote (event) {
            var { target: { note } } = event

            var noteElem = document.createElement('div')

            app.crypto.decrypt(note.content)
                .then(json => {
                    var note = JSON.parse(json)
                    console.log('note:', note)
                    riot.mount(noteElem, 'note', note)
                })
                .catch(err => {
                    console.error('Can\'t decrypt message', err)
                })


            console.log('Opening popup ', noteElem, 'Target:', note)
            map.openPopup(noteElem, note.location)
        }

        /**
         * Draws all markers to the map and sets the popup to display the note's
         * contents.
         *
         * @param  {Array[Note]} notes  The notes to display
         */
        updateMarkers (notes) {
            map.closePopup()

            markers.forEach(marker => {
                map.removeLayer(marker)
            })

            markers = []

            notes.forEach(note => {
                var marker = L.marker(note.location)
                marker.note = note
                marker.addTo(map).on('click', this.showNote)

                markers.push(marker)
            })
        }

        this.on('mount', this.init)

        app.on('notes:create', this.createNote)
        app.on('notes:changed', this.updateMarkers)
        app.on('home', () => map.closePopup())
    </script>
</map>
