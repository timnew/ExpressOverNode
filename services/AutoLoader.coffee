_ = require('lodash')
path = require('path')
fs = require('fs')

class AutoLoader
  constructor: (@__rootPath) ->
    files = fs.readdirSync(@__rootPath)

    @__names = []
    _.forEach files, (file) =>
      extName = path.extname file
      if require.extensions[extName]?
        name = path.basename file, extName
        fullname = path.join(@__rootPath, file)
        @__names.push name
        Object.defineProperty this, name,
          get: ->
            require(fullname)

createAutoLoader = (rootPath) ->
  new AutoLoader(rootPath)

createAutoLoader.AutoLoader = AutoLoader

exports = module.exports = createAutoLoader
