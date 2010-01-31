require 'git'

module GitBro
  class Repository
    def initialize(repo_path)
      @git = Git.open(repo_path)
    end

    def path
      @git.repo.path.gsub('.git','')
    end

    def root
      sha = @git.log(1).first.sha
      dir(sha)
    end

    def file_content(sha)
      @git.object(sha).contents
    end

    def dir(sha)
      objs = []
      tree = @git.ls_tree(sha)
      tree['blob'].each do |k,v|
        objs << {:name => k, :sha => v[:sha], :type => 'file'}
      end
      tree['tree'].each do |k,v|
        objs << {:name => k + '/', :sha => v[:sha], :type => 'dir'}
      end

      objs
    end
  end

end
