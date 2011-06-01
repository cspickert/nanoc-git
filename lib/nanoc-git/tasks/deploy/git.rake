# encoding: utf-8

namespace :deploy do
  desc 'Upload the compiled site using git'
  task :git do
    config_name = ENV['config'] || :default
    
    deployer = NanocGit::Extra::Deployers::Git.new
    deployer.run(:config_name => config_name)
  end
end
