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
    s.files = FileList["[a-z]*", "[A-Z]*", "{bin,docs,lib,test}/**/*"]
    s.add_dependency "grit"
    s.add_dependency "sinatra"
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

