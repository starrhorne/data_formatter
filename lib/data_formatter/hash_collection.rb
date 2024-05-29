module DataFormatter
  class HashCollection < Collection
    def open
      @open ||= case lang
      when "php"
        Tag.new(css_class: "bracket", content: "[")
      else
        Tag.new(css_class: "curly-bracket", content: "{")
      end
    end

    def close
      @close ||= case lang
      when "php"
        Tag.new(css_class: "bracket", content: "]")
      else
        Tag.new(css_class: "curly-bracket", content: "}")
      end
    end

    def prepare(data)
      data.map { |k, v| ValuePair.new(key: Value.new(data: k, indentation: indentation, is_key: true), value: Value.new(data: v, indentation: indentation, lang: lang, key_name: k), lang: lang) }
    end
  end
end
