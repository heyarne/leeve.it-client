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
        this.modes = {
            choose: 'CHOOSE',
            markdown: 'MARKDOWN',
            image: 'IMAGE'
        }

        this.on('mount', (options) => {

            this.mode = options ? this.modes[options.mode] : this.modes.choose
            console.log('Mounted with options', options)
            console.log('Starting in mode', this.mode)
        })
    </script>
</note-form>
