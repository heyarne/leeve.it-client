require('../markdown.tag')

<markdown-edit>
    <textarea hide={preview} placeholder="Write some markdown…" onkeyup={ updateText }>{ text }</textarea>
    <markdown text={text} show={preview} />

    <a href="#" onclick={startPreview} hide={preview}>Preview</a>
    <a href="#" onclick={endPreview} show={preview}>Edit</a>

    <script>
        this.preview = opts.preview || false
        this.text = opts.text || ''

        this.startPreview = () => {
            this.preview = true
        }

        this.endPreview = () => {
            this.preview = false
        }

        this.updateText = (event) => {
            this.text = event.target.value
        }
    </script>
</markdown-edit>
