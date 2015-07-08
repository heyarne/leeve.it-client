var gulp = require('gulp')

var browserSync = require('browser-sync').create()

// var browserify = require('browserify')
// var source = require('vinyl-source-stream')
// var buffer = require('vinyl-buffer')
// var gutil = require('gulp-util')
// var uglify = require('gulp-uglify')
// var sourcemaps = require('gulp-sourcemaps')

// gulp.task('javascript', function () {
//   // set up the browserify instance on a task basis
//   var b = browserify({
//     entries: './src/js/init.js',
//     debug: true,
//     // defining transforms here will avoid crashing your stream
//     transform: []
//   })

//   return b.bundle()
//         .on('error', gutil.error)
//     .pipe(source('bundle.js')) // source takes text as input and emits a file
//     .pipe(buffer())
//     .pipe(sourcemaps.init({loadMaps: true}))
//         // Add transformation tasks to the pipeline here.
//         .pipe(uglify())
//         .on('error', gutil.log)
//     .pipe(sourcemaps.write('./'))
//     .pipe(gulp.dest('./dist/js/'))
// })

// gulp.task('watch', function () {
//   gulp.watch(['./src/js/**/*.js'], ['javascript'])
// })

gulp.task('serve', /*['javascript', 'watch'],*/ function (done) {
  browserSync.init({
    server: {
      baseDir: './src',
      routes: {
        '/node_modules': './node_modules'
      }
    },
    https: true
  }, done)

  // watch compiled files and sourcefiles that are not going to be compiled (html
  // and css)
  gulp.watch([
    './src/*.html',
    './src/css/*.css'
    // './dist/**/*'
  ]).on('change', browserSync.reload)
})
