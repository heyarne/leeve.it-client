require('./note-form-image.tag')
require('./note-form-markdown.tag')

<note-form>
    <h1>Create Note</h1>
    <ul show={mode === modes.choose}>
        <li><a href="#">Markdown note</a></li>
        <li><a href="#">Image note</a></li>
    </ul>
    <image show={mode === modes.image} />
    <markdown show={mode === modes.markdown } />

    <script>
        this.mode = null

        this.on('mount', (options) => {
            this.modes = {
                choose: Symbol('choose'),
                markdown: Symbol('markdown'),
                image: Symbol('image')
            }

            var mode = options ? options.mode : this.modes.choose
            this.mode = this.modes[mode]
            console.log('Mounted with options', options)
            console.log('Starting in mode', this.mode)
        })
    </script>
</note-form>
