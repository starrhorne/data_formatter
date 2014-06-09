require "data_formatter/version"
require "data_formatter/indentation"
require "data_formatter/collection"
require "data_formatter/array_collection"
require "data_formatter/hash_collection"
require "data_formatter/value"
require "data_formatter/value_pair"
require "data_formatter/tag"

module DataFormatter
  def self.format(data) 
    HashCollection.new(data: data, indentation: Indentation.new()).to_s
  end

  def self.format_lines(data) 
    format(data).strip.split("\n")
  end
end
