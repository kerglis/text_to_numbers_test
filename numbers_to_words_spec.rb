require 'rspec'
require './numbers_to_words.rb'

describe NumbersToWords do

  describe Integer do
    it { expect(1.to_words).to eq "one" }
    it { expect(-1.to_words).to eq "minus one" }
    it { expect(10.to_words).to eq "ten" }
    it { expect(11.to_words).to eq "eleven" }
    it { expect(69.to_words).to eq "sixty-nine" }
    it { expect(101.to_words).to eq "one hundred one" }
    it { expect(4321.to_words).to eq "four thousand, three hundred twenty-one" }
    it { expect(12345.to_words).to eq "twelve thousand, three hundred forty-five" }
  end

  describe Float do
    it { expect(1.01.to_words).to eq({ integral: "one", fraction: "01" }) }
    it { expect(-11.11.to_words).to eq({ integral: "minus eleven", fraction: "11" }) }
  end

end
