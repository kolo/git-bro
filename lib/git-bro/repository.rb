require 'grit'

module GitBro
  class Repository
    def initialize(repo_path)
      @repo = Grit::Repo.new(repo_path)
    end

    def path
      @repo.path.gsub('.git','')
    end

    def root
      tree(@repo.commits('master', 1).first.sha)
    end

    def file_content(sha)
      @repo.blob(sha).data
    end

    def tree(sha)
      objs = []
      @repo.tree(sha).trees.each do |t|
        objs << {:name => t.basename + '/', :sha => t.id, :type => 'dir'}
      end
      @repo.tree(sha).blobs.each do |b|
        objs << {:name => b.basename, :sha => b.id, :type => 'file'}
      end

      objs
    end
  end

end
