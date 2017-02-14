require_relative "ruby-tutor/version"

class RubyTutor
  LENGTH_CLASSES = [String, Array, Hash].freeze
  KEYS_VALS = [Hash].freeze

  def self.explain(object, type = nil)
    explanation = type.nil? ? base_explanation(object) : []

    puts explanation.join("\n")
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

  def self.base_explanation(object)
    explain_string = []
    class_name = object.class
    ancestors = object.class.ancestors[1..-1].join(', ')

    explain_string << "Instance of Class: #{class_name}"
    explain_string << "Value: #{object}" unless KEYS_VALS.include? class_name
    explain_string << "Keys: #{object.keys.join(', ')}" if KEYS_VALS.include? class_name
    explain_string << "Values: #{object.values.join(', ')}" if KEYS_VALS.include? class_name
    explain_string << "Length: #{object.length}" if LENGTH_CLASSES.include?(class_name)
    explain_string << "Mutable? #{object.frozen? ? 'No' : 'Yes'}"
    explain_string << "Object ID: #{object.object_id}"
    explain_string << "Inhertits From: #{ancestors}"
    explain_string << ""
    explain_string << retrieve_description(object)
  end

  def self.retrieve_description(object)
    class_name = object.class
    description = ["Description:\n"]

    files = []
    files << File.expand_path("../descriptions/intro.txt", __FILE__)
    files << File.expand_path("../descriptions/#{class_name}.txt", __FILE__)
    files << File.expand_path("../descriptions/last.txt", __FILE__)


    files.each do |file_path|
      File.open(file_path) do |file|
        file.each do |line|
          description << format(line, value:  object,
                                      length: object.length,
                                      class: object.class)
        end
      end
    end

    description.join
  end

  def self.valid?(letter)
    begin
      letter.length == 1 && !!letter.downcase.match(/[a-z]/)
    rescue
      false
    end
  end
end

hash = {a: 1, b: 2, c: 3}
hash.length
RubyTutor.explain hash
