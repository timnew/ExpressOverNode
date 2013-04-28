_ = require('lodash')

path = require('path')
createAutoLoader = require('../../services/AutoLoader.coffee')

describe 'AutoLoader', ->
  describe 'create with path', ->
    subject  = createAutoLoader path.join(__dirname, 'AutoLoaderData')

    it 'should create subject', ->
      subject.should.be.ok

    it 'should require JavaScript', ->
      subject.should.have.ownProperty 'JavaScript'
      subject.__names.should.contain 'JavaScript'
      subject.JavaScript.name.should.equal 'JavaScript'

    it 'should require CoffeeScript', ->
      subject.should.have.ownProperty 'CoffeeScript'
      subject.__names.should.contain 'CoffeeScript'
      subject.CoffeeScript.name.should.equal 'CoffeeScript'

    it 'should load lazily', ->
      subject.Counter.get('Lazy').should.equal 0
      subject.Lazy
      subject.Counter.get('Lazy').should.equal 1
      subject.Lazy
      subject.Counter.get('Lazy').should.equal 1

    it 'should populate __names', ->
      subject.__names.should.have.length(4)

  describe 'create with object', ->
    subject  = createAutoLoader
      http: 'http'
      _: 'lodash'
      JS: path.join(__dirname, 'AutoLoaderData', 'JavaScript')

    it 'should create subject', ->
      subject.should.be.ok

    it 'should require native module', ->
      subject.should.have.ownProperty 'http'
      subject.__names.should.contain 'http'
      subject.http.should.equal require('http')

    it 'should require package', ->
      subject.should.have.ownProperty '_'
      subject.__names.should.contain '_'
      subject._.should.equal require('lodash')

    it 'should require file', ->
      subject.should.have.ownProperty 'JS'
      subject.__names.should.contain 'JS'
      subject.JS.should.equal require path.join(__dirname, 'AutoLoaderData', 'JavaScript')

    it 'should populate __names', ->
      subject.__names.should.have.length(3)

  describe 'create with array', ->
    subject  = createAutoLoader ['http', 'lodash', path.join(__dirname, 'AutoLoaderData', 'JavaScript')]

    it 'should create subject', ->
      subject.should.be.ok

    it 'should require native module', ->
      subject.should.have.ownProperty 'http'
      subject.__names.should.contain 'http'
      subject.http.should.equal require('http')

    it 'should require package', ->
      subject.should.have.ownProperty 'lodash'
      subject.__names.should.contain 'lodash'
      subject.lodash.should.equal require('lodash')

    it 'should require file', ->
      subject.should.have.ownProperty 'JavaScript'
      subject.__names.should.contain 'JavaScript'
      subject.JavaScript.should.equal require path.join(__dirname, 'AutoLoaderData', 'JavaScript')

    it 'should populate __names', ->
      subject.__names.should.have.length(3)