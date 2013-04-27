# Smoke Test for test environment configuration, fails when environment is not correctly configured

describe 'environment', ->
  describe 'Basic check', ->
    it 'chai', ->
      true.should.be.ok

    it 'coffee-script', ->
      require.extensions['.coffee'].should.be.ok

    it 'createAutoLoader', ->
      createAutoLoader.should.be.instanceOf Function

    it 'createPathHelper', ->
      createPathHelper.should.be.instanceOf Function

    it 'rootPath', ->
      rootPath.should.be.instanceOf Function
      rootPath.specs().should.equal __dirname

    it 'configuration', ->
      Configuration.should.be.ok

  describe 'autoload', ->
    it 'Services', ->
      Services.should.be.instanceOf Object

    it 'Routes', ->
      Routes.should.be.instanceOf Object

    xit 'Models', ->
      Models.should.be.instanceOf Object

    xit 'Records', ->
      Records.should.be.instanceOf Object
