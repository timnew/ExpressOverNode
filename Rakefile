desc "Launch app in default mode"
task :app => 'app:watch'

namespace :app do
  desc "Launch the app"
  task :run do
    sh 'coffee app'
  end

  desc "Start the app with auto-realod"
  task :watch do
    sh %q{supervisor -i specs,views -e coffee,js app.coffee}
  end
end

desc "Run spec in default mode"
task :spec => %w[spec:once]

namespace :spec do
  desc "Run specs once"
  task :once, :test_files do |t, args|
    args.with_defaults test_files: 'specs/*Spec.coffee specs/**/*Spec.coffee'
    sh %Q[mocha -r 'specs/specHelper.js' -R spec -G -t 5000 #{args.test_files}]
  end

  desc "Run the specs when file changes"
  task :watch, :test_files do |t, args|
    args.with_defaults test_files: 'specs/*Spec.coffee specs/**/*Spec.coffee'
    sh %Q[mocha -r 'specs/specHelper.js' -R spec -w -G -t 5000 #{args.test_files}]
  end
end

desc "Launch default console"
task :console => 'console:node'

namespace :console do
  desc "Launch default node console"
  task :node do
    puts "require('coffee-script'); require('./initEnvironment');"
    sh %q{node}
  end

  desc "Launch coffee console"
  task :coffee do
    sh %q{coffee -r "./initEnvironment"}
  end
end


