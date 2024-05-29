require "test_helper"

describe "version" do
  it "must be defined" do
    _(DataFormatter::VERSION).wont_be_nil
  end

  it "formats an empty hash" do
    _(DataFormatter.format({})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => string hash" do
    _(DataFormatter.format({"a" => "b"})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"b\" data-kind=\"string\">&quot;b&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "escapes quotes in strings" do
    _(DataFormatter.format({"a" => '"hi"'})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"\"hi\"\" data-kind=\"string\">&quot;\\&quot;hi\\&quot;&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "escapes newlines in strings" do
    _(DataFormatter.format({"a" => "b\nc"})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"b\\nc\" data-kind=\"string\">&quot;b\\nc&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "escapes carragereturns in strings" do
    _(DataFormatter.format({"a" => "b\rc"})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"b\\rc\" data-kind=\"string\">&quot;b\\rc&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "escapes tabs in strings" do
    _(DataFormatter.format({"a" => "b\tc"})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"b\\tc\" data-kind=\"string\">&quot;b\\tc&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => number hash" do
    _(DataFormatter.format({"a" => 2})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\" data-key=\"a\" data-value=\"2\" data-kind=\"number\">2</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a number => string hash" do
    _(DataFormatter.format({3 => "hi"})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key number\">3</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"3\" data-value=\"hi\" data-kind=\"string\">&quot;hi&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => nil hash" do
    _(DataFormatter.format({"a" => nil})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"nil\" data-key=\"a\" data-value=\"nil\" data-kind=\"nil\">nil</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => true hash" do
    _(DataFormatter.format({"a" => true})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"boolean\" data-key=\"a\" data-value=\"true\" data-kind=\"boolean\">true</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => false hash" do
    _(DataFormatter.format({"a" => false})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"boolean\" data-key=\"a\" data-value=\"false\" data-kind=\"boolean\">false</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => [] hash" do
    _(DataFormatter.format({"a" => []})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"bracket\">[</span><span class=\"bracket\">]</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => [1, 'x', nil] hash" do
    _(DataFormatter.format({"a" => [1, "x", nil]})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"bracket\">[</span>\n&nbsp;&nbsp;<span class=\"number\" data-value=\"1\" data-kind=\"number\">1</span>,\n&nbsp;&nbsp;<span class=\"string\" data-value=\"x\" data-kind=\"string\">&quot;x&quot;</span>,\n&nbsp;&nbsp;<span class=\"nil\" data-value=\"nil\" data-kind=\"nil\">nil</span>\n<span class=\"bracket\">]</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => {'a' => 1} hash" do
    _(DataFormatter.format({"a" => {"b" => 1}})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;b&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\" data-key=\"b\" data-value=\"1\" data-kind=\"number\">1</span><span class=\"curly-bracket\">}</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string 'a' => 1, 'b' => 2} hash" do
    _(DataFormatter.format({"a" => {"a" => 1, "b" => 2}})).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"curly-bracket\">{</span>\n&nbsp;&nbsp;<span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\" data-key=\"a\" data-value=\"1\" data-kind=\"number\">1</span>,\n&nbsp;&nbsp;<span class=\"key string\">&quot;b&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\" data-key=\"b\" data-value=\"2\" data-kind=\"number\">2</span>\n<span class=\"curly-bracket\">}</span><span class=\"curly-bracket\">}</span>")
  end

  it "handles complex nested arrays" do
    data = {"warden.user.user.key" => ["User", ["1"], "$2a$10$KA1Gt0FHACfN7i0t0A7Ly."]}
    DataFormatter.format(data)
  end

  it "Formats a string" do
    _(DataFormatter.format("Hello")).must_equal("<span class=\"string\" data-value=\"Hello\" data-kind=\"string\">&quot;Hello&quot;</span>")
  end

  it "Formats a symbol" do
    _(DataFormatter.format(:hello)).must_equal("<span class=\"symbol\" data-value=\":hello\" data-kind=\"symbol\">:hello</span>")
  end

  it "Formats an array" do
    _(DataFormatter.format(["Hello", "there"])).must_equal("<span class=\"bracket\">[</span>\n&nbsp;&nbsp;<span class=\"string\" data-value=\"Hello\" data-kind=\"string\">&quot;Hello&quot;</span>,\n&nbsp;&nbsp;<span class=\"string\" data-value=\"there\" data-kind=\"string\">&quot;there&quot;</span>\n<span class=\"bracket\">]</span>")
  end

  it "Formats a literal" do
    _(DataFormatter.format("[LITERAL]Hello")).must_equal("<span class=\"literal\" data-value=\"Hello\" data-kind=\"literal\">Hello</span>")
  end

  describe "JavaScript-style" do
    it "formats a string => string hash" do
      _(DataFormatter.format({"a" => "b"}, "js")).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;:&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"b\" data-kind=\"string\">&quot;b&quot;</span><span class=\"curly-bracket\">}</span>")
    end

    it "formats a string => nil hash" do
      _(DataFormatter.format({"a" => nil}, "js")).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;:&nbsp;</span><span class=\"nil\" data-key=\"a\" data-value=\"null\" data-kind=\"nil\">null</span><span class=\"curly-bracket\">}</span>")
    end
  end

  describe "PHP-style" do
    it "formats a string => string hash" do
      _(DataFormatter.format({"a" => "b"}, "php")).must_equal("<span class=\"bracket\">[</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\" data-key=\"a\" data-value=\"b\" data-kind=\"string\">&quot;b&quot;</span><span class=\"bracket\">]</span>")
    end

    it "formats a string => nil hash" do
      _(DataFormatter.format({"a" => nil}, "php")).must_equal("<span class=\"bracket\">[</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"nil\" data-key=\"a\" data-value=\"null\" data-kind=\"nil\">null</span><span class=\"bracket\">]</span>")
    end
  end
end
