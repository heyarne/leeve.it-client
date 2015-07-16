require('../markdown.tag')

<markdown-editor>
    <div class="markdown-editor">
        <textarea hide={preview} placeholder="Write some markdown…" onkeyup={ updateText }>{ text }</textarea>
        <markdown show={preview} text={text} />

        <a href="#" onclick={startPreview} hide={preview}>Preview</a>
        <a href="#" onclick={endPreview} show={preview}>Edit</a>
    </div>

    <script>
        this.preview = opts.preview || false
        this.text = opts.text || ''

        startPreview () {
            this.preview = true
        }

        endPreview () {
            this.preview = false
        }

        updateText (event) {
            this.text = event.target.value
        }

        getNote () {
            return {
                mimeType: 'text/x-markdown',
                text: this.text
            }
        }
    </script>
</markdown-editor>
