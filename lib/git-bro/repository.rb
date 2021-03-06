require 'grit'

module GitBro
  class Repository
    attr_reader :name

    def initialize(repo_path, opts = nil)
      @repo = Grit::Repo.new(repo_path, opts)
      @name = begin
                dirs = @repo.path.split('/')
                dirs.delete_at(dirs.size - 1) if dirs[-1] == '.git'
                dirs[-1]
              end

      @cache = {}
    end

    def path
      @repo.path.gsub('.git','')
    end

    def file_content(branch, filepath)
      blobs = @repo.tree(branch, [].push(filepath)).blobs
      if blobs.size != 1
        return 'FILE NOT FOUND'
      end

      blobs.first.data
    end

    def get_commit_info(branch, object_id, object_name, current_time)
      if @cache.has_key?(object_id)
        commit_info = @cache[object_id]
      else
        lc = last_commit(branch, object_name)
        commit_info = {
          :author => lc.author.name,
          :commit_time => lc.date,
          :message => lc.message.shortify
        }
        @cache[object_id] = commit_info
      end

      commit_info[:age] = commit_info[:commit_time].relative_to(current_time)

      return commit_info
    end

    def commits_info(branch, path)
      commits = {}

      cur_time = Time.now
      paths = path.empty? ? [] : [].push(path + '/')
      tree = @repo.tree(branch, paths)

      tree.trees.each do |t|
        object_id = t.id.to_sym
        commits[object_id] = get_commit_info(branch, object_id, t.name, cur_time)
      end

      tree.blobs.each do |b|
        object_id = b.id.to_sym
        commits[object_id] = get_commit_info(branch, object_id, b.name, cur_time)
      end

      return commits
    end

    def tree(branch, paths)
      objects = []
      tree = @repo.tree(branch, paths)

      tree.trees.each do |t|
        object_info = { :type => 'dir', :name => t.basename + '/', :sha => t.id, :commit_info => @cache[t.id.to_sym] }
        objects.push(object_info)
      end
      tree.blobs.each do |b|
        object_info = { :type => 'file', :name => b.basename, :sha => b.id, :commit_info => @cache[b.id.to_sym] }
        objects.push(object_info)
      end

      return objects
    end

    def branches
      @repo.heads
    end

    def log(branch, page, per_page = 20)
      @repo.log(branch, nil, {:skip => page * per_page, :n => per_page})
    end

    def commit(sha)
      @repo.commit(sha)
    end

    def default_branch
      branches = @repo.heads.collect!{|h| h.name }
      return "master" if branches.include?("master")

      branches.first
    end

    def top_commit(branch)
      @repo.commits(branch, 1).first
    end

  protected
    # TODO: Check what returns log function if there is dir and file with equal names
    def last_commit(branch, filename)
      lc = @repo.log(branch, filename, {:n => 1})
      lc.empty? ? nil : lc.first
    end
  end
end
