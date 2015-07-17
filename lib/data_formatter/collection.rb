module DataFormatter
  class Collection

    attr_reader :items, :indentation, :separator, :lang

    def initialize(args)
      @indentation = args.fetch(:indentation)
      @separator = args.fetch(:separator, ",")
      @lang = args.fetch(:lang, "ruby")
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
      end.map do |x| 
        x.to_s.force_encoding("UTF-8") 
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
