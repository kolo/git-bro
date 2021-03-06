# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile.rb, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{git-bro}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dmitry Maksimov"]
  s.date = %q{2010-05-04}
  s.default_executable = %q{git-bro}
  s.description = %q{Git-bro provides tools to serve your Git repositories}
  s.email = %q{dmtmax@gmail.com}
  s.executables = ["git-bro"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.html",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.html",
     "README.rdoc",
     "bin/git-bro",
     "docs/created.rid",
     "docs/files/LICENSE.html",
     "docs/files/README_rdoc.html",
     "docs/fr_class_index.html",
     "docs/fr_file_index.html",
     "docs/fr_method_index.html",
     "docs/index.html",
     "docs/rdoc-style.css",
     "lib/git-bro.rb",
     "lib/git-bro/commands.rb",
     "lib/git-bro/commands/serve.rb",
     "lib/git-bro/core_extensions.rb",
     "lib/git-bro/repository.rb",
     "lib/git-bro/sinatra/helpers.rb",
     "sinatra/app.rb",
     "sinatra/public/images/file.png",
     "sinatra/public/images/folder.png",
     "sinatra/public/js/application.js",
     "sinatra/public/js/jquery-1.4.2.js",
     "sinatra/views/application.sass",
     "sinatra/views/coderay.sass",
     "sinatra/views/commit.haml",
     "sinatra/views/commit_details.haml",
     "sinatra/views/commits.haml",
     "sinatra/views/dir.haml",
     "sinatra/views/file_content.haml",
     "sinatra/views/index.haml",
     "sinatra/views/layout.haml",
     "sinatra/views/menu.haml",
     "sinatra/views/tree.haml",
     "test/git-bro.git/HEAD",
     "test/git-bro.git/config",
     "test/git-bro.git/description",
     "test/git-bro.git/hooks/applypatch-msg.sample",
     "test/git-bro.git/hooks/commit-msg.sample",
     "test/git-bro.git/hooks/post-commit.sample",
     "test/git-bro.git/hooks/post-receive.sample",
     "test/git-bro.git/hooks/post-update.sample",
     "test/git-bro.git/hooks/pre-applypatch.sample",
     "test/git-bro.git/hooks/pre-commit.sample",
     "test/git-bro.git/hooks/pre-rebase.sample",
     "test/git-bro.git/hooks/prepare-commit-msg.sample",
     "test/git-bro.git/hooks/update.sample",
     "test/git-bro.git/info/exclude",
     "test/git-bro.git/objects/pack/pack-668e7a3976d53d070420e5877925f8472aaf569d.idx",
     "test/git-bro.git/objects/pack/pack-668e7a3976d53d070420e5877925f8472aaf569d.pack",
     "test/git-bro.git/objects/pack/pack-6f8375d1e612aff7cf5777d6fb1d0ca463f8e49d.idx",
     "test/git-bro.git/objects/pack/pack-6f8375d1e612aff7cf5777d6fb1d0ca463f8e49d.pack",
     "test/git-bro.git/refs/heads/develop",
     "test/git-bro.git/refs/heads/master",
     "test/git-bro/test_repository.rb",
     "test/helper.rb"
  ]
  s.homepage = %q{http://github.com/kolo/git-bro}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Serve and browse your Git repositories}
  s.test_files = [
    "test/git-bro/test_repository.rb",
     "test/helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<grit>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<coderay>, [">= 0"])
    else
      s.add_dependency(%q<grit>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<coderay>, [">= 0"])
    end
  else
    s.add_dependency(%q<grit>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<coderay>, [">= 0"])
  end
end

