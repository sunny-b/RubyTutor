require_relative 'test_helper'

class RubyTutorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil RubyTutor::VERSION
  end

  def test_something
    assert true
  end
end
