module DataFormatter
  class ValuePair
    attr_reader :key, :value, :lang, :separator

    # Defaults to JavaScript (JSON)
    SEPARATORS = Hash.new(":").update({
      "ruby" => "=&gt;",
      "php" => "=&gt;"
    }).freeze

    def initialize(args)
      @key = args.fetch(:key)
      @value = args.fetch(:value)
      @lang = args.fetch(:lang, "ruby")
      @separator = SEPARATORS[@lang]
    end

    def to_s
      [key.to_s, %(<span class="hashrocket">&nbsp;#{separator}&nbsp;</span>), value.to_s].join
    end
  end
end
