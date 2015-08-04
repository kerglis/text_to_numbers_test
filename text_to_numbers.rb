require 'pry'

class TextToNumbers

  TO_19 =  %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  BIG_TENS =  %w(twenty thirty forty fifty sixty seventy eighty ninety)

  TEN_POWERED = {
    "hundred" => 2,
    "thousand" => 3,
    "million" => 6,
    "billion" => 9,
    "trillion" => 12
  }

  def initialize(text)
    @text = text
    @output_str = ""
    @parentises_opened = false
  end

  def open_parentises
    unless @parentises_opened
      @output_str = "#{@output_str}("
      @parentises_opened = true
    end
  end

  def close_parentises
    if @parentises_opened
      @output_str = "#{@output_str})"
      @parentises_opened = false
    end
  end

  def to_number
    open_parentises

    @text.split(/ +/).each_with_index do |particle, idx|
      res = resolve_value(particle)

      close_parentises if res[:close_parentises]
      @output_str += res[:method] if idx > 0
      open_parentises if res[:open_parentises]

      @output_str += res[:value].to_s
    end

    close_parentises
    eval(@output_str)
  end

  def resolve_value(str)
    return resolve_to_19(str) if TO_19.include?(str)
    return resolve_tens(str) if BIG_TENS.include?(str)
    return resolve_ten_powered(str) if TEN_POWERED.include?(str)
    raise "something wrong"
  end

  def resolve_to_19(str)
    {
      value: TO_19.find_index(str),
      method: "+",
      open_parentises: true
    }
  end

  def resolve_tens(str)
    {
      value: (BIG_TENS.find_index(str) + 2)*10,
      method: "+"
    }
  end

  def resolve_ten_powered(str)
    {
      value: 10 ** TEN_POWERED[str],
      method: "*",
      close_parentises: str != "hundred"
    }
  end

end


class String
  def to_number
    TextToNumbers.new(self).to_number
  end
end
