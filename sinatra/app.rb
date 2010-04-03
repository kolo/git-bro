#! /usr/bin/ruby

require 'rubygems'
require 'git-bro'
require 'sinatra'
require 'haml'
require 'sass'
require 'git-bro/sinatra/helpers'
require 'git-bro/sinatra/core_extensions'
require 'json'

set :run, true

begin
  exit(1) if ARGV.size != 1
  repository = GitBro::Repository.new(File.expand_path(ARGV.first))
rescue ArgumentError
  puts "Cannot locate a repository in #{ARGV.first}"
  exit 1
end

# Routes

get '/' do
  @branches = repository.branches
  haml :index
end

get '/tree/:branch' do
  branch = params[:branch]

  @url_prefix = "/tree/#{branch}"
  @path = "#{repository.name}/"
  @git_state = {:branch => branch, :path => ""}
  @objs = repository.tree_objects(branch, [])

  haml :dir_listing
end

get '/tree/:branch/*/' do
  branch = params[:branch]
  path = params[:splat].first

  @url_prefix = "/tree/#{branch}/#{path}"
  @path = "#{repository.name}/#{path}/"
  @git_state = {:branch => branch, :path => path}
  @objs = repository.tree_objects(branch, [].push(path + '/'))

  haml :dir_listing
end

get '/tree/:branch/*' do
  @content = repository.file_content(params[:branch], params[:splat].first)
  haml :file_content
end

get '/commits' do
  if request.xhr?
    commits = repository.commits_info(params[:branch], params[:path])

    content_type :json
    commits.to_json
  else
    redirect '/'
  end
end

get '/commits/:branch' do
  @page = params[:page] ? params[:page].to_i : 0
  @branch = params[:branch]
  @per_page = 50

  @commits = repository.log(@branch, @page, @per_page)
  haml :commits
end

get '/commit/:sha' do
  @commit = repository.commit(params[:sha])
  haml :commit
end

# CSS files

get '/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end

get '/coderay.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :coderay
end
