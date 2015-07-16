module DataFormatter
  class ValuePair

    attr_reader :key, :value, :lang, :separator

    Separators = {
      "ruby" => "=&gt;",
      "js" => ":"
    }

    def initialize(args)
      @key = args.fetch(:key)
      @value = args.fetch(:value)
      @lang = args.fetch(:lang, "ruby")
      @separator = Separators[@lang]
    end

    def to_s
      [key.to_s, %Q{<span class="hashrocket">&nbsp;#{separator}&nbsp;</span>}, value.to_s].join
    end

  end
end
