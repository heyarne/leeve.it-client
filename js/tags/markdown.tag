<markdown>
    <div class="markdown">{html}</div>

    <script>
        var marked = require('marked')

        this.on('update', () => {
            this.html = opts.text ? marked(opts.text) : ''
            this.root.innerHTML = this.html
        })
    </script>
</markdown>
