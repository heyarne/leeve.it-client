require('../markdown.tag')

<note>
    <pre>
        mime: {{mimeType}}<br>
        value: {{value}}
    </pre>

    <script>
        this.mimeType = opts.mimeType
        this.value = opts.value
    </script>
</note>
