require 'grit'

module GitBro
  class Repository
    attr_reader :name

    def initialize(repo_path, opts = nil)
      @repo = Grit::Repo.new(repo_path, opts)
      @name = @repo.path.split('/')[-2]
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

    def commits_info(branch, path)
      commits = {}

      cur_time = Time.now
      paths = path.empty? ? [] : [].push(path + '/')
      tree = @repo.tree(branch, paths)

      tree.trees.each do |t|
        lc = last_commit(branch, t.name)
        commits[t.id.to_sym] = {
          :author => lc.author.name,
          :age => relative(cur_time - lc.date, lc.date),
          :message => shortify(lc.message)
        }
      end

      tree.blobs.each do |b|
        lc = last_commit(branch, b.name)
        commits[b.id.to_sym] = {
          :author => lc.author.name,
          :age => relative(cur_time - lc.date, lc.date),
          :message => shortify(lc.message)
        }
      end

      return commits
    end

    def tree_objects(branch, paths)
      objects = []
      tree = @repo.tree(branch, paths)

      tree.trees.each do |t|
        objects << { :type => 'dir', :name => t.basename + '/', :sha => t.id }
      end
      tree.blobs.each do |b|
        objects << { :type => 'file', :name => b.basename, :sha => b.id }
      end

      return objects
    end

    def branches
      @repo.heads
    end

  protected
    # TODO: Check what returns log function if there is dir and file with equal names
    def last_commit(branch, filename)
      lc = @repo.log(branch, filename, {:n => 1})
      lc.empty? ? nil : lc.first
    end

    def shortify(s)
      s.length > 40 ? s[0..40] + '...' : s
    end

    def relative(diff, orig)
      return "#{diff.to_i} seconds ago" if diff < 60
      return "#{(diff/60).to_i} minutes ago" if diff < 3600
      return "#{(diff/3600).to_i} hours ago" if diff < 86400
      return "#{(diff/86400).to_i} days ago" if diff < 604800

      orig.strftime("%B %d, %Y")
    end

  end
end
