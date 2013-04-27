_ = require('lodash')

path = require('path')
createAutoLoader = require('../../services/AutoLoader.coffee')

describe 'AutoLoader', ->
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
