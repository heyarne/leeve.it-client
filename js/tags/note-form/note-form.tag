require('./image-upload.tag')
require('./markdown-edit.tag')

<note-form>
    <div class="note-form">
        <h1>Create Note</h1>

        <ul class="choose" show={mode === modes.choose}>
            <li><a href="#" onclick={ markdownMode }>Markdown note</a></li>
            <li><a href="#" onclick={ imageMode }>Image note</a></li>
        </ul>

        <div hide={mode === modes.choose}>
            <a href="#" onclick={ chooseMode }>&laquo; back</a>
        </div>

        <form if={mode !== modes.choose} onsubmit={ handleSubmit }>
            <image-upload show={mode === modes.image} />
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

        /**
         * Updates the mode the note form is in to "choose", where a list to
         * choose between modes is displayed
         */
        chooseMode () {
            thise.mode = this.modes.choose
        }

        /**
         * Sets form into markdown mode, shows a markdown editor with preview
         */
        markdownMode () {
            this.mode = this.modes.markdown
        }

        /**
         * Sets form into image upload mode, shows a file picker which allows to
         * upload images and also has a built-in preview
         */
        imageMode () {
            this.mode = this.modes.image
        }

        /**
         * Fetches the notes content from the currently mounted tag, encrypts it
         * and signals the app that a new note has been created
         */
        handleSubmit () {
            var tag = (this.mode === this.modes.markdown) ? 'markdown-editor' : 'image-upload'
            var note = this.tags[tag].getNote()
            var latLng = this.latLng

            app.crypto.encrypt(JSON.stringify(note))
                .then(encryptedNote => {
                    app.trigger('notes:new', new Note({
                        content: encryptedNote,
                        location: latLng
                    }))
                })
                .catch(err => console.error('Could not encrypt message', err))
        }
    </script>
</note-form>
