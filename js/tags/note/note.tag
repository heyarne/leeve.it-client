require('../markdown.tag')

<note>
    <markdown text={content} if={ mimeType === 'text/x-markdown' } />
    <img src={content} if={ mimeType.match(/^image\//) } />

    <script>
        this.mimeType = opts.type
        this.content = opts.content
    </script>
</note>
