var gulp = require('gulp')
var gutil = require('gulp-util')

var webpack = require('webpack')
var WebpackDevServer = require('webpack-dev-server')
var webpackConfig = require('./webpack.config')

gulp.task('webpack', function(done) {
    // run webpack
    webpack(webpackConfig, function(err, stats) {
        if(err) throw new gutil.PluginError('webpack', err)
        gutil.log('[webpack]', stats.toString({
            // output options
        }))
        done()
    })
})

gulp.task('webpack-dev-server', function(callback) {
    // Start a webpack-dev-server
    var config = Object.create(webpackConfig)
    config.debug = true
    config.devtool = 'source-map'

    var compiler = webpack(config)

    new WebpackDevServer(compiler, {
        contentBase: __dirname,

        hot: true,
        inline: true,

        quiet: false,
        noInfo: false,
        lazy: true,
        https: true,

        filename: "bundle.js",
        aggregateTimeout: 150,
        publicPath: "/"
    }).listen(8001, 'localhost', function(err) {
        if(err) throw new gutil.PluginError('webpack-dev-server', err)
        // Server listening
        gutil.log('[webpack-dev-server]', 'https://localhost:8001/webpack-dev-server/index.html')

        // keep the server alive or continue?
        // callback()
    })
})

gulp.task('build', ['webpack'])
gulp.task('serve', ['webpack-dev-server'])
