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

        <image-upload show={mode === modes.image}></image-upload>
        <markdown-editor show={mode === modes.markdown } />
    </div>

    <script>
        this.modes = {
            choose: Symbol('choose'),
            markdown: Symbol('markdown'),
            image: Symbol('image')
        }
        this.mode = opts.mode ? this.modes[opts.mode] : this.modes.choose

        chooseMode () {
            thise.mode = this.modes.choose
        }

        markdownMode () {
            this.mode = this.modes.markdown
        }

        imageMode () {
            this.mode = this.modes.image
        }
    </script>
</note-form>
