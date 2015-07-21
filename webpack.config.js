var webpack = require('webpack')

module.exports = {
  entry: './js/app.js',
  debug: true,
  devtool: 'cheap-module-source-map',
  output: {
    filename: 'bundle.js'
  },
  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot'
    }),
    // openpgpjs depends on node-localstorage which emulates localstorage on the
    // server. this in turn requires fs in an incompatible way; since we're
    // running it in the browser anyways, it's safe to ignore it.
    new webpack.IgnorePlugin(/^fs$/)
    // new webpack.optimize.DedupePlugin(),
    // new webpack.optimize.UglifyJsPlugin({
    //     mangle: {
    //         except: ['$super', '$', 'exports', 'require']
    //     }
    // })
  ],
  module: {
    preLoaders: [
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader' }
    ],
    loaders: [
      { test: /\.js|\.tag$/, exclude: /node_modules/, loader: 'babel-loader' }
    ]
  }
}
