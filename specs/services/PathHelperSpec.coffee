path = require('path')
createPathHelper = require('../../services/PathHelper.coffee')

describe "Expand Path", ->
  rootPath  = createPathHelper path.join(__dirname, 'PathHelperData/something/..')

  it "should expand Path root path", ->
    rootPath().should.equal path.join(__dirname, 'PathHelperData')

  it "should expand file paths", ->
    rootPath('File').should.equal path.join(__dirname, 'PathHelperData', 'File')
    rootPath('file.ext').should.equal path.join(__dirname, 'PathHelperData', 'file.ext')

  it "should expand multiple path", ->
    rootPath('subdir', 'file').should.equal path.join(__dirname, 'PathHelperData', 'subdir', 'file')

  it "should consolidate dir path", ->
    consolidateReturns = rootPath.consolidate()
    consolidateReturns.should.equal rootPath
    rootPath.subdir().should.equal path.join(__dirname, 'PathHelperData', 'subdir')
    rootPath.subdir('file').should.equal path.join(__dirname, 'PathHelperData', 'subdir', 'file')

  it 'should create path object', ->
    pathObj = rootPath.toPathObject()
    pathObj.should.eql
      File: path.join(__dirname, 'PathHelperData', 'File')
      file: path.join(__dirname, 'PathHelperData', 'file.ext')
      subdir: path.join(__dirname, 'PathHelperData', 'subdir')

  it 'should create consolidated instance', ->
    consolidatedRootPath  = createPathHelper path.join(__dirname, 'PathHelperData/something/..'), true
    consolidatedRootPath.subdir.should.be.instanceOf Function
