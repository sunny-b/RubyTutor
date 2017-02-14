require_relative 'rubytutor/version'

class RubyTutor
  LENGTH_CLASSES = [String, Array, Hash].freeze
  KEYS_VALS = [Hash].freeze
  NO_VAL = [Hash, Proc, Struct].freeze
  RETURN_VAL = [Proc].freeze

  def self.explain_full(object, type = nil)
    puts full_explanation(object, type).join("\n")
  end

  def self.describe(object, type = nil)
    puts retrieve_description(object, type)
  end

  def self.explain(object, type = nil)
    puts retrieve_explanation(object, type).join("\n")
  end

  def self.available_methods(object, letter = nil)
    class_name = object.class == Class ? object : object.class
    methods = retrieve_methods(class_name, letter)

    puts methods
  end

  private

  def self.retrieve_methods(class_name, letter = nil)
    methods_string = "Available Methods: \n"
    method_names = class_name.methods.sort

    if valid?(letter)
      method_names = method_names.map(&:to_s).select do |method|
        method[0] == letter
      end
    end

    methods_string += method_names.join("\n").to_s + "\n\n"
  end

  def self.retrieve_explanation(object, type = nil)
    explain_string = []
    express_type = interpret(type)
    class_name = retrieve_class(object)
    ancestors = class_name.ancestors[1..-1].join(', ')

    explain_string << "Instance of Class: #{class_name}"
    explain_string << "Return Value: #{object.call}" if RETURN_VAL.include? class_name
    explain_string << "Source Value: #{object.source}" if class_name == Regexp
    explain_string << "Value: #{object.nil? ? 'nil' : object}" unless NO_VAL.include? class_name
    explain_string << "Members: #{object.members.join(', ')}" if class_name == Struct
    explain_string << "Keys: #{object.keys.join(', ')}" if KEYS_VALS.include? class_name
    explain_string << "Values: #{object.values.join(', ')}" if KEYS_VALS.include? class_name
    explain_string << "Length: #{object.length}" if LENGTH_CLASSES.include?(class_name)
    explain_string << "Mutable? #{object.frozen? ? 'No' : 'Yes'}"
    explain_string << "Object ID: #{object.object_id}"
    explain_string << "Inhertits From: #{ancestors}"
    explain_string << ""
  end

  def self.full_explanation(object, type)
    full_string = []

    full_string << retrieve_explanation(object, type)
    full_string << retrieve_description(object, type)
    full_string.flatten
  end

  def self.retrieve_description(object, type = nil)
    class_name = retrieve_class(object)
    description = ["Description:\n"]
    files = []

    find(files, class_name)
    extract_contents(files, description, object, class_name)
    description.join
  end

  def self.valid?(letter)
    begin
      letter.length == 1 && !!letter.downcase.match(/[a-z]/)
    rescue
      false
    end
  end

  def self.interpret(type)
    return nil unless type
    type.split.map(&:capitalize).join(' ')
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
    blank_file = File.expand_path("../descriptions/blank.txt", __FILE__)

    files << File.expand_path("../descriptions/intro.txt", __FILE__)
    files << (File.file?(class_file) ? class_file : blank_file)
    files << File.expand_path("../descriptions/last.txt", __FILE__)
  end
end
