global.createAutoLoader = require('./services/AutoLoader')
global.createPathHelper = require('./services/PathHelper')

global.rootPath = createPathHelper(__dirname, true)

global.Configuration = require(rootPath.config('configuration'))

global.Services = createAutoLoader rootPath.services()
global.Routes = createAutoLoader rootPath.routes()
#global.Records = createAutoLoader rootPath.records()
#global.Models = createAutoLoader rootPath.models()

global.assets = {} # initialize this context for connect-assets helpers
