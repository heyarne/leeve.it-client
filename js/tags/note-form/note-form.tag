require('./image-upload.tag')
require('./markdown-edit.tag')

<note-form>
    <div class="note-form">
        <h1>Create Note</h1>

        <ul show={mode === modes.choose}>
            <li><a href="#" onclick={ markdownMode }>Markdown note</a></li>
            <li><a href="#" onclick={ imageMode }>Image note</a></li>
        </ul>

        <div hide={mode === modes.choose}>
            <a href="#" onclick={ chooseMode }>&laquo; back</a>
        </div>

        <form if={mode !== modes.choose} onsubmit={ handleSubmit }>
            <image-upload show={mode === modes.image}></image-upload>
            <markdown-editor show={mode === modes.markdown } />

            <button type="submit">Upload</button>
        </form>
    </div>

    <script>
        var app = require('ampersand-app')
        var Note = require('../../models/note')

        this.modes = {
            choose: Symbol('choose'),
            markdown: Symbol('markdown'),
            image: Symbol('image')
        }
        this.mode = opts.mode ? this.modes[opts.mode] : this.modes.choose
        this.latLng = opts.latLng

        chooseMode () {
            thise.mode = this.modes.choose
        }

        markdownMode () {
            this.mode = this.modes.markdown
        }

        imageMode () {
            this.mode = this.modes.image
        }

        handleSubmit () {
            var tag = (this.mode === this.modes.markdown) ? 'markdown-editor' : 'image-upload'
            var note = this.tags[tag].getNote()

            app.crypto.encrypt(JSON.stringify(note))
                .then(encryptedNote => {

                    app.trigger('notes:new', new Note({
                        content: encryptedNote,
                        location: this.latLng
                    }))
                })
                .catch(err => console.error('Could not encrypt message', err))
        }
    </script>
</note-form>
