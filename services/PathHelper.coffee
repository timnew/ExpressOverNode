_ = require('lodash')
fs = require('fs')
path = require('path')

createPathHelper = (rootPath, isConsolidated) ->
  rootPath = path.normalize rootPath
  result = (args...) ->
    return rootPath if args.length == 0
    parts = _.flatten [rootPath, args]
    path.join.apply(this, parts)

  result.toPathObject = ->
    self = result()
    files = fs.readdirSync(self)
    pathObj = {}

    for file in files
      fullName = path.join(self, file)
      extName =  path.extname(file)
      name = path.basename(file, extName)
      pathObj[name] = fullName

    pathObj

  result.consolidate = ->
    pathObj = result.toPathObject()

    for name, fullName of pathObj
      stats = fs.statSync(fullName)
      result[name] = createPathHelper(fullName) if stats.isDirectory()

    result

  if isConsolidated
    result.consolidate()
  else
    result

exports = module.exports = createPathHelper