module DataFormatter
  class ArrayCollection < Collection

    def open
      @open ||= Tag.new(css_class: "bracket", content: "[")
    end

    def close
      @close ||= Tag.new(css_class: "bracket", content: "]")
    end

    def prepare(data)
      data.map { |v| Value.new(data: v, indentation: indentation) }
    end

  end
end
