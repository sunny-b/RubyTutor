require_relative 'test_helper'

class RubyTutorTest < Minitest::Test
  def setup
    output = StringIO.new
    $stdout = output
  end

  def test_that_it_has_a_version_number
    refute_nil RubyTutor::VERSION
  end

  def test_explain_string
    assert_nil RubyTutor.explain 'a'
    assert $stdout.string.match(/Class: String/)
    assert $stdout.string.match(/Value: a/)
    assert $stdout.string.match(/Length: 1/)
  end

  def test_explain_array
    assert_nil RubyTutor.explain [1, 2, 3]
    assert $stdout.string.match(/Class: Array/)
    assert $stdout.string.match(/Value: \[1, 2, 3\]/)
    assert $stdout.string.match(/Length: 3/)
  end

  def teardown
    $stdout = STDOUT
  end
end
