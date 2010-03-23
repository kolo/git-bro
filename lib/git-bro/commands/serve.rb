module GitBro
  # Provides functions for implementing serve command
  module ServeCommand
    def serve_arguments_valid?
      @arguments.size <= 1 ? true : false
    end

    def serve_process_arguments
      @options.repo_path = @arguments.size == 1 ? @arguments.first : Dir.pwd
    end

    def do_serve
      case GitBro::TARGET_OS
      when 'mswin32'
        system "ruby #{@options.gem_path}/sinatra/app.rb #{@options.repo_path}"
      when 'linux'
        system "/usr/bin/env ruby #{@options.gem_path}/sinatra/app.rb #{@options.repo_path}"
      end
    end
  end
end

