#! /usr/bin/ruby

require 'rubygems'
require 'git-bro'
require 'sinatra'
require 'haml'
require 'sass'
require 'git-bro/sinatra/helpers'
require 'json'

set :run, true

begin
  exit(1) if ARGV.size != 1
  repository = GitBro::Repository.new(File.expand_path(ARGV.first))
rescue ArgumentError
  puts "Cannot locate a repository in #{ARGV.first}"
  exit 1
end

set :branch, repository.default_branch
set :branches, Proc.new{ repository.branches.collect!{|b| b.name}.sort }

Languages = {
  '.rb' => :ruby,
  '.gemspec' => :ruby
}

# Routes

get '/' do
  @branch = settings.branch

  set :branch, @branch
  redirect "/tree/#{@branch}"
end

get '/tree/:branch' do
  @branch = params[:branch]

  @url_prefix = "/tree/#{@branch}"
  @path = "#{repository.name}/"
  @git_state = {:branch => @branch, :path => ""}
  @objs = repository.tree(@branch, [])
  @top_commit = repository.top_commit(@branch)

  set :branch, @branch
  haml :tree
end

get '/tree/:branch/*/' do
  @branch = params[:branch]
  path = params[:splat].first

  @url_prefix = "/tree/#{@branch}/#{path}"
  @path = "#{repository.name}/#{path}/"
  @git_state = {:branch => @branch, :path => path}
  @objs = repository.tree(@branch, [].push(path + '/'))
  @top_commit = repository.top_commit(@branch)

  set :branch, @branch
  haml :tree
end

get '/tree/:branch/*' do
  @branch = params[:branch]
  filename = params[:splat].first
  @path = "#{repository.name}/#{filename}"
  @lang = Languages[File.extname(filename)]
  @content = repository.file_content(@branch, filename)

  set :branch, @branch
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

  set :branch, @branch
  haml :commits
end

get '/commit/:sha' do
  @branch = settings.branch
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
