require "data_formatter/version"
require "data_formatter/indentation"
require "data_formatter/collection"
require "data_formatter/array_collection"
require "data_formatter/hash_collection"
require "data_formatter/value"
require "data_formatter/value_pair"
require "data_formatter/tag"

module DataFormatter
  def self.format(data, lang = "ruby")
    Value.new(data: data, indentation: Indentation.new(), lang: lang).to_s
  end

  def self.format_lines(data, lang = "ruby")
    format(data, lang).strip.split("\n")
  end
end
