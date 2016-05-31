require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe '#balance' do
    it 'allows user to see starting balance of zero' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up oystercard' do
  		expect{oystercard.top_up(1)}.to change{oystercard.balance}.by 1
  	end

    it 'raises an error if balance exceeds max limit' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      message = "Balance can not exceed £#{Oystercard::MAX_BALANCE}"
      expect{oystercard.top_up(1)}.to raise_error message 
    end
  end

  describe '#in_journey?' do
    it 'reports when oystercard is in use' do
      oystercard.top_up(1)
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end

    it 'reports when oystercard is not in use' do
      oystercard.top_up(10)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it 'reports initialized oystercard not in use' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'raises an error if the balance is insufficient' do
      message = "Insufficient balance"
      expect{ oystercard.touch_in}.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'reduces the balance by minimum fare' do
      oystercard.top_up(10)
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MIN_FARE) 
    end
  end

end
