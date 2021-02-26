require "rack/utils"

module DataFormatter
  class Tag
    attr_reader :sanitizer, :content, :css_class, :tag_name, :surround

    def initialize(args)
      @sanitizer = args.fetch(:sanitizer, Rack::Utils)
      @tag_name = args.fetch(:tag_name, "span")
      @content = args.fetch(:content)
      @surround = args.fetch(:surround, nil)
      @css_class = Array(args.fetch(:css_class, "")).compact.join(" ")
    end

    def to_s
      [open_tag, safe_content, close_tag].join
    end

    protected

    def escaped_surround
      "\\" + surround
    end

    def surrounded_content
      if surround
        [surround, content.gsub(surround, escaped_surround), surround].join
      else
        content
      end
    end

    def safe_content
      sanitizer.escape_html(surrounded_content)
    end

    def open_tag
      %(<#{tag_name} class="#{css_class}">)
    end

    def close_tag
      %(</#{tag_name}>)
    end
  end
end
