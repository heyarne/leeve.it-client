require('../markdown.tag')

<note>
    <div class="note">
        <img class="thumbnail" src={note.content.value} if={isImage()} />
        <markdown text={note.content.value} if={isMarkdown()} />
        <span class="time-info">Created at <time datetime={note.createdAt}>{{getDate()}}</time></span>
    </div>

    <script>
        this.note = opts

        /**
         * Returns true if the note is some kind of image
         *
         * @return {Boolean}
         */
        isImage() {
            return this.note.content.mimeType.match(/^image\//)
        }

        /**
         * Returns true if the note's mimetype is one of the two registered for
         * markdown documents.
         *
         * @return {Boolean}
         */
        isMarkdown() {
            return [ 'text/x-markdown', 'text/markdown' ].indexOf(this.note.content.mimeType) > -1
        }

        /**
         * Helper function to return the formatted date
         *
         * @return {String}
         */
        getDate() {
            var date = new Date(this.note.createdAt)
            var day = date.getDate()
            var month = date.getMonth()
            var year = date.getFullYear()
            var minutes = date.getMinutes()
            var hours = date.getHours()

            // add leading 0s if necessary as all of the above getters return integers
            if (day < 10) day = "0" + day
            if (month < 10) month = "0" + month
            if (minutes < 10) minutes = "0" + minutes
            if (hours < 10) hours = "0" + hours

            return `${day}.${month}.${year}, ${hours}:${minutes}h`
        }
    </script>
</note>
