<image-upload>
    <div class="image-upload">
        <img class="thumbnail" src="{thumb}" if={thumb} />
        <input type="file" accept="image/jpeg,image/gif,image/png" onchange={ fileInput } />
    </div>

    <script>
        var reader = new FileReader()

        this.thumb = null

        fileInput (e) {
            var file = e.target.files[0]
            if (!file.type.match('image.*')) return

            reader.readAsDataURL(file)
        }

        reader.onload = (e) => {
            var base64 = e.target.result
            console.log('Loaded image: ', e)

            this.thumb = base64
            this.update()
        }
    </script>
</image-upload>
