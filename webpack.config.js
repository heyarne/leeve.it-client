var webpack = require('webpack')

module.exports = {
  entry: './js/app.js',
  debug: true,
  devtool: 'eval-cheap-module-source-map',
  output: {
    filename: 'bundle.js'
  },
  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot'
    })
  ],
  module: {
    preLoaders: [
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader', query: { type: 'none' } }
    ],
    loaders: [
      { test: /\.js|\.tag$/, exclude: /node_modules/, loader: 'babel-loader' }
    ]
  }
}
