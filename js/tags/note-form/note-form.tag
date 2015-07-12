require('./note-form-image.tag')
require('./markdown-edit.tag')

<note-form>
    <h1>Create Note</h1>
    <ul show={mode === modes.choose}>
        <li><a href="#" onclick={ markdownMode }>Markdown note</a></li>
        <li><a href="#" onclick={ imageMode }>Image note</a></li>
    </ul>

    <div hide={mode === modes.choose}>
        <a href="#" onclick={ chooseMode }>&laquo; back</a>
    </div>

    <note-form-image show={mode === modes.image}></note-form-image>
    <markdown-edit show={mode === modes.markdown } />

    <script>
        this.modes = {
            choose: Symbol('choose'),
            markdown: Symbol('markdown'),
            image: Symbol('image')
        }
        this.mode = this.modes[opts.mode] || this.modes.choose

        this.chooseMode = () => {
            thise.mode = this.modes.choose
        }

        this.markdownMode = () => {
            this.mode = this.modes.markdown
        }

        this.imageMode = () => {
            this.mode = this.modes.image
        }
    </script>
</note-form>
