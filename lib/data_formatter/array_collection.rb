module DataFormatter
  class ArrayCollection < Collection
    LIMIT = 1000

    def open
      @open ||= Tag.new(css_class: "bracket", content: "[")
    end

    def close
      @close ||= Tag.new(css_class: "bracket", content: "]")
    end

    def prepare(data)
      data.first(LIMIT).map { |v| Value.new(data: v, indentation: indentation, lang: lang) }
    end
  end
end
