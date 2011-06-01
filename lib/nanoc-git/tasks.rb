# encoding: utf-8

require 'rake'

module NanocGit::Tasks
end
  
Dir[File.dirname(__FILE__) + '/tasks/**/*.rb'].each   { |f| load f }
Dir[File.dirname(__FILE__) + '/tasks/**/*.rake'].each { |f| Rake.application.add_import(f) }
