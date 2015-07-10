var gulp = require('gulp')
var gutil = require('gulp-util')

var webpack = require('webpack')
var browserSync = require('browser-sync').create()
var webpackConfig = require('./webpack.config')

gulp.task('webpack', function(done) {
    var config = Object.create(webpackConfig)

    // run webpack
    webpack(config, function(err, stats) {
        if(err) throw new gutil.PluginError('webpack', err)
        gutil.log('[webpack]', stats.toString({
          colors: true
        }))
        done()
    })
})

gulp.task('browser-sync', ['webpack'], function () {
  browserSync.init({
    server: {
      baseDir: '.',
      index: 'index.html'
    },
    https: true,
    ghostMode: false,
    port: 8001
  })

  gulp.watch('bundle.js').on('change', browserSync.reload)
  gulp.watch('css/*.css').on('change', browserSync.reload)
  gulp.watch('index.html').on('change', browserSync.reload)
  gulp.watch('js/**/*.js', ['webpack'])
})

gulp.task('build', ['webpack'])
gulp.task('serve', ['browser-sync'])
