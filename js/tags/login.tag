<login>
    <div id="login-container">
        <ul id="login-buttons">
            <li class="google-signin">
                <div class="g-signin2" data-onsuccess="googleAuthSuccess" data-onfailure="googleAuthFailure"></div>
            </li>
        </ul>
    </div>

    <script>
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
            console.log(res)

            fetch(_url('users/me'), { credentials: 'include' })
              .then(function (res) { return res.json() })
              .then(function (res) { console.log(res) })
              .catch(console.error.bind(console))
          }).catch(function (err) {
            console.error('Could not verify the OpenID JWT')
            console.error(err.message)
          })
        }

        function googleAuthFailure () {
          console.error('Oh nose :(')
          console.log(arguments)
        }

        this.on('mount', function () {
            window.googleAuthSuccess = googleAuthSuccess
            window.googleAuthFailure = googleAuthFailure
        })
    </script>
</login>
