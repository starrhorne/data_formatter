module DataFormatter
  class Collection

    attr_reader :items, :indentation, :separator

    def initialize(args)
      @indentation = args.fetch(:indentation)
      @separator = args.fetch(:separator, ",")
      @items = prepare(args.fetch(:data))
    end

    def to_s
      return inline if items.length < 2 

      [].tap do |output|
        output << open
        indentation.increase
        items.each_with_index do |item, i| 
          output << indent(item) + separator(i)
        end
        indentation.decrease
        output << indent(close)
      end.join("\n")
    end

    protected

      def prepare(items)
        items
      end

      def open
        nil
      end

      def close
        nil
      end

      def inline
        [open, items[0].to_s, close].compact.join
      end

      def separator(i)
        (i < items.length-1) ? "," : ""
      end

      def indent(item)
        indentation.indent(item)
      end

  end
end
