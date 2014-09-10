require 'test_helper'
 
describe "version" do
 
  it "must be defined" do
    DataFormatter::VERSION.wont_be_nil
  end

  it "formats an empty hash" do
    DataFormatter.format({}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => string hash" do
    DataFormatter.format({"a" => "b"}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\">&quot;b&quot;</span><span class=\"curly-bracket\">}</span>")
  end
  
  it "escapes quotes in strings" do
    DataFormatter.format({"a" => '"hi"'}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\">&quot;\\&quot;hi\\&quot;&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "escapes newlines in strings" do
    DataFormatter.format({"a" => "b\nc"}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\">&quot;b\\nc&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "escapes carragereturns in strings" do
    DataFormatter.format({"a" => "b\rc"}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\">&quot;b\\rc&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => number hash" do
    DataFormatter.format({"a" => 2}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\">2</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a number => string hash" do
    DataFormatter.format({3 => "hi"}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key number\">3</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"string\">&quot;hi&quot;</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => nil hash" do
    DataFormatter.format({"a" => nil}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"nil\">nil</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => true hash" do
    DataFormatter.format({"a" => true}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"boolean\">true</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => false hash" do
    DataFormatter.format({"a" => false}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"boolean\">false</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => [] hash" do
    DataFormatter.format({"a" => []}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"bracket\">[</span><span class=\"bracket\">]</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => [1, 'x', nil] hash" do
    DataFormatter.format({"a" => [1, 'x', nil]}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"bracket\">[</span>\n&nbsp;&nbsp;<span class=\"number\">1</span>,\n&nbsp;&nbsp;<span class=\"string\">&quot;x&quot;</span>,\n&nbsp;&nbsp;<span class=\"nil\">nil</span>\n<span class=\"bracket\">]</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string => {'a' => 1} hash" do
    DataFormatter.format({"a" => {"b" => 1}}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;b&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\">1</span><span class=\"curly-bracket\">}</span><span class=\"curly-bracket\">}</span>")
  end

  it "formats a string 'a' => 1, 'b' => 2} hash" do
    DataFormatter.format({"a" => {"a" => 1, "b" => 2}}).must_equal("<span class=\"curly-bracket\">{</span><span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"curly-bracket\">{</span>\n&nbsp;&nbsp;<span class=\"key string\">&quot;a&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\">1</span>,\n&nbsp;&nbsp;<span class=\"key string\">&quot;b&quot;</span><span class=\"hashrocket\">&nbsp;=&gt;&nbsp;</span><span class=\"number\">2</span>\n<span class=\"curly-bracket\">}</span><span class=\"curly-bracket\">}</span>")
  end

  it "handles complex nested arrays" do
    data = {"warden.user.user.key"=>["User", ["1"], "$2a$10$KA1Gt0FHACfN7i0t0A7Ly."]}
    DataFormatter.format(data)
  end

  it "Formats a string" do
    DataFormatter.format("Hello").must_equal("<span class=\"string\">&quot;Hello&quot;</span>")
  end

  it "Formats an array" do
    DataFormatter.format(["Hello", "there"]).must_equal("<span class=\"bracket\">[</span>\n&nbsp;&nbsp;<span class=\"string\">&quot;Hello&quot;</span>,\n&nbsp;&nbsp;<span class=\"string\">&quot;there&quot;</span>\n<span class=\"bracket\">]</span>")
  end

end
