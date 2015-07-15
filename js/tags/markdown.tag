<markdown>
    <div class="markdown">{html}</div>

    <script>
        var marked = require('marked')

        this.on('update', () => {
            try {
                this.html = opts.text ? marked(opts.text) : ''
                this.root.innerHTML = this.html
            } catch (e) {
                console.error('Markdown error', e)
            }
        })
    </script>
</markdown>
