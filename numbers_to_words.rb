class NumbersToWords

  # borrowing some ideas from
  # http://www.blackwasp.co.uk/NumberToWords.aspx

  TO_19 =  %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  TENS =  %w(twenty thirty forty fifty sixty seventy eighty ninety)
  DENOM = [ "", "thousand", "million", "billion", "trillion" ] # continue for even bigger 1000^N denominations

  def self.convert(val)
    return "minus " + convert(-val)   if val < 0
    return convert_NN(val)            if val < 100
    return convert_NNN(val)           if val < 1000

    DENOM.each_with_index do |denom, v|
      denom_idx = v - 1
      denom_val = 1000 ** v

      if (denom_val > val)
        mod = 1000 ** denom_idx
        left = val / mod
        right = val - (left * mod)

        ret = convert_NNN(left) + " " + DENOM[denom_idx]
        ret = ret + ", " + convert(right) if right > 0
        return ret
      end
    end

    raise ArgumentError, "Could not parse value"
  end

  # convert value < 100 to english
  def self.convert_NN(val)
    return TO_19[val] if val < 20

    TENS.each_with_index do |tens_cap, v|
      d_val = 20 + 10 * v

      if d_val + 10 > val
        return tens_cap + "-" + TO_19[val % 10] if (val % 10) != 0
        return tens_cap
      end
    end

    raise ArgumentError, "Value should be less than 100"
  end

  # convert value < 1000 to english
  # special cased because it is the level that kicks off the < 100 special case
  def self.convert_NNN(val)
    word = ""
    rem = val / 100
    mod = val % 100

    if rem > 0
      word = TO_19[rem] + " hundred"
      word = word + " " if mod > 0
    end

    word = word + convert_NN(mod) if mod > 0
    word
  end

end


class Integer
  def to_words
    NumbersToWords::convert(self)
  end
end


class Float
  def to_words
    parts = self.to_s.split '.'
    {
      integral: NumbersToWords::convert(parts[0].to_i),
      fraction: parts[1]
    }
  end
end
