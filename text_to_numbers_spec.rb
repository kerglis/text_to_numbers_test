require 'rspec'
require './text_to_numbers.rb'

describe TextToNumbers do

  it { expect("five".to_number).to eq 5 }
  it { expect("twenty five".to_number).to eq 25 }
  it { expect("one thousand six hundred fifty five".to_number).to eq 1655 }
  it { expect("two thousand forty".to_number).to eq 2040 }
  it { expect("two hundred seventy one million".to_number).to eq 271000000 }
  it { expect("three hundred seventy one thousand six hundred fifty five".to_number).to eq 371655 }
  it { expect("two hundred seventy one million three hundred seventy one thousand six hundred fifty five".to_number).to eq 271371655 }

end
