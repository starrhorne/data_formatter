module DataFormatter
  class ValuePair

    attr_reader :key, :value

    def initialize(args)
      @key = args.fetch(:key)
      @value = args.fetch(:value)
    end

    def to_s
      [key.to_s, '<span class="hashrocket">&nbsp;=&gt;&nbsp;</span>', value.to_s].join
    end

  end
end
