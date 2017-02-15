require_relative 'rubytutor/version'

# RubyTutor main class
class RubyTutor
  def self.explain_full(object)
    puts full_explanation(object).join("\n")
  end

  def self.describe(object)
    puts retrieve_description(object)
  end

  def self.explain(object)
    puts retrieve_explanation(object).join("\n")
  end

  def self.available_methods(object, filter_str = nil)
    class_name = object.class == Class ? object : object.class
    methods = retrieve_methods(class_name, filter_str)

    puts methods
  end

  private_class_method

  def self.retrieve_methods(class_name, filter_str = nil)
    method_names = class_name.methods.sort

    if valid?(filter_str)
      last_index = filter_str.length

      method_names = method_names.map(&:to_s).select do |method|
        method[0...last_index] == filter_str
      end
    end

    "Available Methods: \n" + method_names.join("\n").to_s + "\n\n"
  end

  def self.retrieve_explanation(object)
    class_name = retrieve_class(object)
    ancestors = class_name.ancestors[1..-1].join(', ')
    value = object.nil? ? 'nil' : object

    construct_explain(object, class_name, ancestors, value)
  end

  def self.construct_explain(object, class_name, ancestors, value)
    text = []

    text << "Instance of Class: #{class_name}"
    text << "Value: #{value}"

    variable_text(object, text)

    text << "Mutable? #{object.frozen? ? 'No' : 'Yes'}"
    text << "Object ID: #{object.object_id}"
    text << "Inherits From: #{ancestors}"
    text << ''
  end

  # Not pretty, but this is the method that determines which strings will go
  # Into each 'explain' or 'explain_full' call
  def self.variable_text(object, text)
    text << "Return Value: #{object.call}" if need?(object, :call)
    text << "Source Value: #{object.source}" if need?(object, :source)
    text << "Members: #{object.members.join(', ')}" if need?(object, :members)
    text << "Keys: #{object.keys.join(', ')}" if need?(object, :keys)
    text << "Values: #{object.values.join(', ')}" if need?(object, :values)
    text << "Length: #{object.length}" if need?(object, :length)
  end

  def self.need?(object, method_symbol)
    object.respond_to?(method_symbol)
  end

  def self.full_explanation(object)
    full_string = []

    full_string << retrieve_explanation(object)
    full_string << retrieve_description(object)
    full_string.flatten
  end

  def self.retrieve_description(object)
    class_name = retrieve_class(object)
    description = ["Description:\n"]
    files = []

    find(files, class_name)
    extract_contents(files, description, object, class_name)
    description.join
  end

  def self.valid?(letter)
    letter.respond_to?(:match) ? letter.downcase.match(/[a-z]/) : false
  end

  def self.retrieve_class(object)
    object.respond_to?(:members) ? Struct : object.class
  end

  def self.extract_contents(files, description, object, class_name)
    files.each do |file_path|
      File.open(file_path) do |file|
        file.each do |line|
          description << format(line, value: object, class: class_name)
        end
      end
    end
  end

  def self.find(files, class_name)
    class_file = File.expand_path("../descriptions/#{class_name}.txt", __FILE__)
    blank_file = File.expand_path('../descriptions/blank.txt', __FILE__)

    files << File.expand_path('../descriptions/intro.txt', __FILE__)
    files << (File.file?(class_file) ? class_file : blank_file)
    files << File.expand_path('../descriptions/last.txt', __FILE__)
  end
end
