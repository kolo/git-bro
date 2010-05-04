require 'rake'
require 'rake/rdoctask'

$:.unshift("lib")
require "git-bro"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.version = GitBro::VERSION
    s.name = 'git-bro'
    s.executables = "git-bro"
    s.summary = "Serve and browse your Git repositories"
    s.description = "Git-bro provides tools to serve your Git repositories"
    s.email = "dmtmax@gmail.com"
    s.homepage = "http://github.com/kolo/git-bro"
    s.authors = ["Dmitry Maksimov"]
    s.files = FileList["[A-Z]*", "{bin,docs,lib,test,sinatra}/**/*"]
    s.add_dependency "grit"
    s.add_dependency "sinatra"
    s.add_dependency "haml"
    s.add_dependency "json"
    s.add_dependency "coderay"
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end

desc 'Builds gem, uninstall old one, install new version'
task :reinstall do
  system("rake build")
  system("sudo gem uninstall -x git-bro")
  system("sudo gem install --no-ri --no-rdoc pkg/git-bro-#{GitBro::VERSION}.gem")
end

require 'rake/testtask'
Rake::TestTask.new do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "Rcov is not available. Install it using: sudo gem install rcov"
  end
end

Rake::RDocTask.new do |rd|
  rd.rdoc_dir = 'docs'
  rd.main = 'README.rdoc'
  rd.rdoc_files.include 'README.rdoc', 'LICENSE'
end
