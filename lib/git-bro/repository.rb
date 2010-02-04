require 'grit'

module GitBro
  class Repository
    def initialize(repo_path)
      @branch = 'master'
      @repo = Grit::Repo.new(repo_path)
    end

    def path
      @repo.path.gsub('.git','')
    end

    def root
      tree('',@repo.commits(@branch, 1).first.sha)
    end

    def file_content(sha)
      @repo.blob(sha).data
    end

    def tree(prefix, sha)
      objs = []
      @repo.tree(sha).trees.each do |t|
        lc = last_commit(prefix + t.basename)
        objs << {
          :type => 'dir',
          :name => t.basename + '/',
          :sha => t.id,
          :author => lc.author.name,
          :message => shortify(lc.message)
        }
      end
      @repo.tree(sha).blobs.each do |b|
        lc = last_commit(prefix + b.basename)
        objs << {
          :type => 'file',
          :name => b.basename,
          :sha => b.id,
          :author => lc.author.name,
          :message => shortify(lc.message)
        }
      end

      objs
    end

  protected
    # TODO: Check what returns log function if there is dir and file with equal names
    def last_commit(filename)
      lc = @repo.log(@branch, filename, {:n => 1})
      lc.empty? ? nil : lc.first
    end

    def shortify(s)
      s.length > 40 ? s[0..37] + '...' : s
    end

  end
end
