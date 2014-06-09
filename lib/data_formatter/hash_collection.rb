module DataFormatter
  class HashCollection < Collection

    def open
      @open ||= Tag.new(css_class: "curly-bracket", content: "{")
    end

    def close
      @close ||= Tag.new(css_class: "curly-bracket", content: "}")
    end

    def prepare(data)
      data.map { |k, v| ValuePair.new(key: Value.new(data: k, indentation: indentation, is_key: true), value: Value.new(data: v, indentation: indentation)) }
    end

  end
end
