var gulp = require('gulp')

var browserSync = require('browser-sync').create()

var browserify = require('browserify')
var source = require('vinyl-source-stream')
var buffer = require('vinyl-buffer')
var gutil = require('gulp-util')
var uglify = require('gulp-uglify')
var sourcemaps = require('gulp-sourcemaps')

gulp.task('javascript', function () {
  // set up the browserify instance on a task basis
  var b = browserify({
    entries: './src/js/app.js',
    debug: true,
    // defining transforms here will avoid crashing your stream
    transform: []
  })

  return b.bundle()
    .pipe(source('app.js')) // source takes text as input and emits a file
    .pipe(buffer())
    .pipe(sourcemaps.init({loadMaps: true}))
        // Add transformation tasks to the pipeline here.
        .pipe(uglify())
        .on('error', gutil.log)
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/js/'))
})

gulp.task('watch', function () {
  gulp.watch(['./src/**/*.js'], ['javascript'])
})

gulp.task('serve', ['javascript', 'watch'], function (done) {
  browserSync.init({
    server: {
      baseDir: ['./src', './dist']
    }
  }, done)

  gulp.watch('./dist/*').on('change', browserSync.reload)
})
