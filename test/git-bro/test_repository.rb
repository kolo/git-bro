require File.dirname(__FILE__) + '/../helper'

class TestRepository < Test::Unit::TestCase
  def setup
    @r = GitBro::Repository.new(File.join(File.dirname(__FILE__), %w[.. git-bro.git]), :is_bare => true)
  end

  def test_not_nil
    assert !@r.nil?
  end

  def test_path
    assert_equal File.expand_path(File.dirname(__FILE__) + '/../git-bro'), @r.path
  end

  def test_tree_with_empty_path
    tree = @r.tree('develop',[])
    assert_equal 7, tree.size
    assert_equal 4, tree.collect{|i| i if i[:type] == 'dir'}.nitems
    assert_equal 3, tree.collect{|i| i if i[:type] == 'file'}.nitems
  end

  def test_tree_with_non_empty_path
    tree = @r.tree('develop',['sinatra/'])
    assert_equal 3, tree.size
    assert_equal 2, tree.collect{|i| i if i[:type] == 'dir'}.nitems
    assert_equal 1, tree.collect{|i| i if i[:type] == 'file'}.nitems
  end

  def test_branches
    branches = @r.branches
    assert_equal 2, branches.size
    assert_equal Grit::Head, branches[0].class
    assert_equal Grit::Head, branches[1].class
  end

  def test_file_content_with_valid_path
    content = @r.file_content('develop','sinatra/app.rb')
    assert_equal 2312, content.size
  end

  def test_file_content_with_invalid_path
    content = @r.file_content('develop', 'sinatra/git-bro')
    assert_equal 'FILE NOT FOUND', content
  end
end
