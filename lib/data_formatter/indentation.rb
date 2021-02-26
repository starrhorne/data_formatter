module DataFormatter
  class Indentation
    INDENT_CHARS = "&nbsp;&nbsp;"

    attr_accessor :indent_level

    def initialize(args = {})
      @indent_level = args.fetch(:indent_level, 0)
    end

    def indent(value)
      to_s + value.to_s
    end

    def increase
      self.indent_level += 1
    end

    def decrease
      self.indent_level = [indent_level - 1, 0].max
    end

    def to_s
      INDENT_CHARS * indent_level
    end
  end
end
