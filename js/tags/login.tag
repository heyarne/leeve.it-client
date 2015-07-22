<login>
    <div id="login-container">
        <ul id="login-buttons" if={!user}>
            <li class="google-signin">
                <div class="g-signin2" data-onsuccess="googleAuthSuccess" data-onfailure="googleAuthFailure"></div>
            </li>
        </ul>

        <div class="user-profile" if={user}>
            <img src="{{user.picture}}" alt="profile picture" class="user-picture" />
            Logged in as {user.alias}
        </div>
    </div>

    <script>
        var app = require('ampersand-app')
        var _url = require('../helpers')._url

        function googleAuthSuccess (googleUser) {
          console.log('Successfully authenticated using google! :)')
          var response = googleUser.getAuthResponse()

          fetch(_url('auth/google/verify'), {
            method: 'post',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            // make sure the cookie we receive is set:
            credentials: 'include',
            body: JSON.stringify({
              idtoken: response.id_token
            })
          }).then(function (res) {
            console.log('Token verified')
            // console.log(res)

            app.trigger('auth')
          }).catch(function (err) {
            console.error('Could not verify the OpenID JWT')
            console.error(err.message)
          })
        }

        function googleAuthFailure () {
          console.error('Oh nose :(')
          console.log(arguments)
        }

        this.user = null

        app.on('login', (user) => {
            this.user = user
            this.update()
        })

        app.on('logout', () => {
            this.user = null
            this.update()
        })

        this.on('mount', function () {
            window.googleAuthSuccess = googleAuthSuccess
            window.googleAuthFailure = googleAuthFailure
        })
    </script>
</login>
