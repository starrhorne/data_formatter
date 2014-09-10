module DataFormatter
  class Value
    attr_reader :value, :is_key, :indentation

    def initialize(args)
      @value = args.fetch(:data)
      @is_key = args.fetch(:is_key, false)
      @indentation = args.fetch(:indentation)
    end

    def to_s
      if is?(Numeric)
        format_number
      elsif is?(String)
        format_string
      elsif is?(TrueClass, FalseClass)
        format_boolean
      elsif is?(NilClass)
        format_nil
      elsif is?(Hash)
        format_hash
      elsif is?(Array)
        format_array
      else
        raise "ValueFormatter value is of unsupported type: #{ value.class.name }"
      end.to_s
    end

    protected

      def is?(*klass)
        klass.any? { |k| value.kind_of?(k) }
      end

      def format_number
        mark_up(data: value, kind: "number" )
      end

      def format_string
        escaped_value = { "\a" => '\a', "\b" => '\b', "\r" => '\r', "\n" => '\n', "\s" => '\s', "\t" => '\t' }.inject(value) do |memo, pair| 
          memo.gsub(pair[0], pair[1])
        end
        mark_up(data: escaped_value, surround: '"', kind: "string" )
      end

      def format_boolean
        mark_up(data: value ? "true" : "false", kind: "boolean" )
      end

      def format_nil
        mark_up(data: "nil", kind: "nil" )
      end

      def format_hash
        HashCollection.new(data: value, indentation: indentation)
      end
      
      def format_array
        ArrayCollection.new(data: value, indentation: indentation)
      end

      def mark_up(args)
        Tag.new(content: args.fetch(:data), surround: args[:surround], css_class: [is_key ? "key" : nil,  args[:kind]]).to_s
      end

  end
end
