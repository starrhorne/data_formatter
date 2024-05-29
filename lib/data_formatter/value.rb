module DataFormatter
  class Value
    attr_reader :value, :is_key, :indentation, :lang, :key_name

    def initialize(args)
      @value = args.fetch(:data)
      @is_key = args.fetch(:is_key, false)
      @indentation = args.fetch(:indentation)
      @lang = args.fetch(:lang, "ruby")
      @key_name = args.fetch(:key_name, nil)
    end

    def to_s
      if is?(Numeric)
        format_number
      elsif is?(String)
        format_string
      elsif is?(Symbol)
        format_symbol
      elsif is?(TrueClass, FalseClass)
        format_boolean
      elsif is?(NilClass)
        format_nil
      elsif is?(Hash)
        format_hash
      elsif is?(Array)
        format_array
      else
        raise "ValueFormatter value is of unsupported type: #{value.class.name}"
      end.to_s
    end

    protected

    def is?(*klass)
      klass.any? { |k| value.is_a?(k) }
    end

    def format_number
      mark_up(data: value, kind: "number")
    end

    def format_symbol
      mark_up(data: value.inspect, kind: "symbol")
    end

    def format_string
      escaped_value = {"\a" => '\a', "\b" => '\b', "\r" => '\r', "\n" => '\n', "\t" => '\t', "\u0000" => '\u0000'}.inject(value) { |memo, pair|
        memo.gsub(pair[0], pair[1])
      }

      if escaped_value.start_with?("[LITERAL]")
        # Return literal value without the hint
        return mark_up(data: escaped_value[9, escaped_value.length], kind: "literal")
      end

      mark_up(data: escaped_value, surround: '"', kind: "string")
    end

    def format_boolean
      mark_up(data: value ? "true" : "false", kind: "boolean")
    end

    def format_nil
      case lang
      when "ruby"
        mark_up(data: "nil", kind: "nil")
      else
        # Default to JavaScript (PHP also uses null)
        mark_up(data: "null", kind: "nil")
      end
    end

    def format_hash
      HashCollection.new(data: value, indentation: indentation, lang: lang)
    end

    def format_array
      ArrayCollection.new(data: value, indentation: indentation, lang: lang)
    end

    def mark_up(args)
      tag_data = if !is_key
        {key: key_name, value: args.fetch(:data), kind: args[:kind]}.compact
      else
        {}
      end
      Tag.new(content: args.fetch(:data), surround: args[:surround], css_class: [is_key ? "key" : nil, args[:kind]], tag_data: tag_data).to_s
    end
  end
end
