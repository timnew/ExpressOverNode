_ = require('lodash')
fs = require('fs')
path = require('path')

createPathHelper = (rootPath, isConsolidated) ->
  rootPath = path.normalize rootPath
  result = (args...) ->
    return rootPath if args.length == 0
    parts = _.flatten [rootPath, args]
    path.join.apply(this, parts)

  result.consolidate = ->
    self = result()
    files = fs.readdirSync(self)
    _.forEach files, (file) ->
      fullName = path.join(self, file)
      stats = fs.statSync(fullName)
      if stats.isDirectory()
        extName = path.extname(file)
        name = path.basename(file, extName)
        result[name] = createPathHelper(fullName)
    result

  if isConsolidated
    result.consolidate()
  else
    result

exports = module.exports = createPathHelper