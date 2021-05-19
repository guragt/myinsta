module.exports = {
  test: /\.erb$/,
  enforce: "pre",
  exclude: /node_modules/,

  use: [{
    loader: "rails-erb-loader",
    options: {
      runner: (/^win/.test(process.platform) ? "ruby " : "") + "bin/rails runner",
      env: {
        ...process.env,
        DISABLE_SPRING: 0,
      },
    },
  }],
}
