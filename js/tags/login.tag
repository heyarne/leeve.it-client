<login-bar>
    <script>
        var googleAuth = require('../auth/google')
        this.on('mount', googleAuth.setup)
    </script>
    <div id="login-container">
        <ul id="login-buttons">
            <li class="google-signin">
                <div class="g-signin2" data-onsuccess="googleAuthSuccess" data-onfailure="googleAuthFailure"></div>
            </li>
        </ul>
    </div>
</login-bar>
