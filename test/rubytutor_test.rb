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
    assert $stdout.string.match(/instance of the String class./)
    assert $stdout.string.match(/A String object is an/)
    assert $stdout.string.match(/Type RubyTutor.available_methods String/)
  end

  def test_explain_array
    assert_nil RubyTutor.explain [1, 2, 3]
    assert $stdout.string.match(/Class: Array/)
    assert $stdout.string.match(/Value: \[1, 2, 3\]/)
    assert $stdout.string.match(/Length: 3/)
    assert $stdout.string.match(/instance of the Array class./)
    assert $stdout.string.match(/Arrays are ordered/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Array/)
  end

  def test_explain_hash
    hash = {a: 1, b: 2, c: 3}
    assert_nil RubyTutor.explain hash
    assert $stdout.string.match(/Class: Hash/)
    assert $stdout.string.match(/Keys: a, b, c/)
    assert $stdout.string.match(/Values: 1, 2, 3/)
    assert $stdout.string.match(/Length: 3/)
    assert $stdout.string.match(/instance of the Hash class./)
    assert $stdout.string.match(/Hash objects are similar/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Hash/)
  end

  def test_explain_false_class
    assert_nil RubyTutor.explain false
    assert $stdout.string.match(/Class: FalseClass/)
    assert $stdout.string.match(/Value: false/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the FalseClass class./)
    assert $stdout.string.match(/The global value false/)
    assert $stdout.string.match(/Type RubyTutor.available_methods FalseClass/)
  end

  def test_explain_true_class
    assert_nil RubyTutor.explain true
    assert $stdout.string.match(/Class: TrueClass/)
    assert $stdout.string.match(/Value: true/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the TrueClass class./)
    assert $stdout.string.match(/The global value true/)
    assert $stdout.string.match(/Type RubyTutor.available_methods TrueClass/)
  end

  def test_explain_nil
    assert_nil RubyTutor.explain nil
    assert $stdout.string.match(/Class: NilClass/)
    assert $stdout.string.match(/Value: nil/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the NilClass class./)
    assert $stdout.string.match(/The NilClass is the class/)
    assert $stdout.string.match(/Type RubyTutor.available_methods NilClass/)
  end

  def test_explain_fixnum
    assert_nil RubyTutor.explain 5
    assert $stdout.string.match(/Class: Fixnum/)
    assert $stdout.string.match(/Value: 5/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the Fixnum class./)
    assert $stdout.string.match(/Fixnum objects hold Integer values/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Fixnum/)
  end

  def test_explain_bignum
    bignum = (2**(0.size * 8 -2))
    assert_nil RubyTutor.explain bignum
    assert $stdout.string.match(/Class: Bignum/)
    assert $stdout.string.match(/Value: 4611686018427387904/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the Bignum class./)
    assert $stdout.string.match(/Bignum objects hold integers/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Bignum/)
  end

  def test_explain_symbol
    assert_nil RubyTutor.explain :symbol
    assert $stdout.string.match(/Class: Symbol/)
    assert $stdout.string.match(/Value: symbol/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the Symbol class./)
    assert $stdout.string.match(/Symbol objects represent names/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Symbol/)
  end

  def test_explain_range
    assert_nil RubyTutor.explain (1..5)
    assert $stdout.string.match(/Class: Range/)
    assert $stdout.string.match(/Value: 1\.\.5/)
    assert $stdout.string.match(/Mutable\? Yes/)
    assert $stdout.string.match(/instance of the Range class./)
    assert $stdout.string.match(/A Range object represents/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Range/)
  end

  def test_explain_float
    assert_nil RubyTutor.explain 5.5
    assert $stdout.string.match(/Class: Float/)
    assert $stdout.string.match(/Value: 5\.5/)
    assert $stdout.string.match(/Mutable\? No/)
    assert $stdout.string.match(/instance of the Float class./)
    assert $stdout.string.match(/Float objects represent inexact/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Float/)
  end

  def test_explain_class
    assert_nil RubyTutor.explain Class
    assert $stdout.string.match(/Class: Class/)
    assert $stdout.string.match(/Value: Class/)
    assert $stdout.string.match(/Mutable\? Yes/)
    assert $stdout.string.match(/instance of the Class class./)
    assert $stdout.string.match(/Classes in Ruby are first-class objects/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Class/)
  end

  def test_explain_module
    assert_nil RubyTutor.explain Comparable
    assert $stdout.string.match(/Class: Module/)
    assert $stdout.string.match(/Value: Comparable/)
    assert $stdout.string.match(/Mutable\? Yes/)
    assert $stdout.string.match(/instance of the Module class./)
    assert $stdout.string.match(/A Module is a collection of methods/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Module/)
  end

  def test_explain_module
    new_proc = Proc.new { 5 }
    assert_nil RubyTutor.explain new_proc
    assert $stdout.string.match(/Class: Proc/)
    assert $stdout.string.match(/Return Value: 5/)
    assert $stdout.string.match(/Mutable\? Yes/)
    assert $stdout.string.match(/instance of the Proc class./)
    assert $stdout.string.match(/Proc objects are blocks/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Proc/)
  end

  def test_explain_struct
    customer = Struct.new(:name, :address, :zip)
    assert_nil RubyTutor.explain customer
    assert $stdout.string.match(/Class: Struct/)
    assert $stdout.string.match(/Members: name, address, zip/)
    assert $stdout.string.match(/Mutable\? Yes/)
    assert $stdout.string.match(/instance of the Struct class./)
    assert $stdout.string.match(/A Struct is a convenient way/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Struct/)
  end

  def test_explain_regexp
    assert_nil RubyTutor.explain /([A-Z])\w+/
    assert $stdout.string.match(/Class: Regexp/)
    assert $stdout.string.match(/Source Value: \(\[A-Z\]\)\\w+/)
    assert $stdout.string.match(/Mutable\? Yes/)
    assert $stdout.string.match(/instance of the Regexp class./)
    assert $stdout.string.match(/A Regexp holds a regular expression/)
    assert $stdout.string.match(/Type RubyTutor.available_methods Regexp/)
  end

  def test_available_methods
    assert_nil RubyTutor.available_methods String
    assert $stdout.string.match(/Available Methods:/)
    assert $stdout.string.match(/!\n!=\n!~\n<\n<=\n<=>/)
    assert $stdout.string.match(/untaint\nuntrust\nuntrusted?/)
  end

  def test_available_methods_filter
    assert_nil RubyTutor.available_methods String, 'u'
    assert $stdout.string.match(/Available Methods:/)
    assert_nil $stdout.string.match(/!\n!=\n!~\n<\n<=\n<=>/)
    assert $stdout.string.match(/untaint\nuntrust\nuntrusted?/)
  end

  def teardown
    $stdout = STDOUT
  end
end

new_proc = Proc.new { 5 }
