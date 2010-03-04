#! /usr/bin/ruby

require 'rubygems'
require 'git-bro'
require 'sinatra'
require 'haml'
require 'sass'
require 'git-bro/sinatra/helpers'

set :run, true

begin
  if ARGV.size != 1
    puts 'USAGE: ruby git-bro <path to git repository>'
    exit 1
  end
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
  @url_prefix = "/tree/#{params[:branch]}"
  @path = "#{repository.name}/"
  @objs = repository.tree(params[:branch], [])
  haml :dir_listing
end

get '/tree/:branch/*/' do
  @url_prefix = "/tree/#{params[:branch]}/#{params[:splat].first}"
  @path = "#{repository.name}/#{params[:splat].first}/"
  @objs = repository.tree(params[:branch], [].push(params[:splat].first + '/'))
  haml :dir_listing
end

get '/tree/:branch/*' do
  @content = repository.file_content(params[:branch], params[:splat].first)
  haml :file_content
end

get '/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end