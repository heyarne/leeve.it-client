<image-upload>
    <div class="image-upload">
        <img class="thumbnail" src="{dataURL}" if={dataURL} />
        <input type="file" accept="image/jpeg,image/gif,image/png" onchange={ fileInput } />
    </div>

    <script>
        var reader = new FileReader()

        this.dataURL = null

        fileInput (e) {
            var file = e.target.files[0]
            if (!file.type.match('image.*')) return

            reader.readAsDataURL(file)
        }

        reader.onload = (e) => {
            var base64 = e.target.result

            this.dataURL = base64
            this.update()
        }

        getValue () {
            return this.dataURL
        }
    </script>
</image-upload>
