require File.dirname(__FILE__) + '/../helper'

class TestRepository < Test::Unit::TestCase
  def setup
    @r = GitBro::Repository.new(File.join(File.dirname(__FILE__), %w[.. dot_git]), :is_bare => true)
  end

  def test_not_nil
    assert !@r.nil?
  end

  def test_path
    assert_equal File.expand_path(File.dirname(__FILE__) + '/../dot_git'), @r.path
  end

  def test_tree
  end
end 

