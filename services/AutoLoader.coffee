_ = require('lodash')
path = require('path')
fs = require('fs')
createPathHelper = require('./PathHelper')

createLoaderMethod = (host, name, fullName) ->
  host.__names.push name
  Object.defineProperty host, name,
                        get: ->
                          require(fullName)

class AutoLoader
  constructor: (source) ->
    @__names = []
    for name, fullName of source
      extName = path.extname fullName
      createLoaderMethod(this, name, fullName) if require.extensions[extName]? or extName == ''

expandPath = (rootPath) ->
  createPathHelper(rootPath).toPathObject()

buildSource = (items) ->
  result = {}

  for item in items
    extName = path.extname(item)
    name = path.basename(item, extName)
    result[name] = item

  result

createAutoLoader = (option) ->
  pathObj = switch typeof(option)
    when 'string'
      expandPath(option)
    when 'object'
      if option instanceof Array
        buildSource(option)
      else
        option

  new AutoLoader(pathObj)

createAutoLoader.AutoLoader = AutoLoader

exports = module.exports = createAutoLoader
