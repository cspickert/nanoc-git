# encoding: utf-8

require 'minitest/autorun'
require 'nanoc-git'
require 'nanoc-git/tasks'

module NanocGit::TestHelpers
  
  def setup
    GC.start
    FileUtils.mkdir_p('tmp')
    FileUtils.cd('tmp')
  end
  
  def teardown
    FileUtils.cd('..')
    FileUtils.rm_rf('tmp')
  end
  
end
