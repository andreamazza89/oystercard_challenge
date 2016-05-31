require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:top_up_amount) {Oystercard::MIN_FARE + 1}
  let(:station) {double(:station)}
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
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'reports when oystercard is not in use' do

      oystercard.top_up(top_up_amount)
      oystercard.touch_in(station)
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
      expect{ oystercard.touch_in(station)}.to raise_error message
    end

    it 'remembers entry station' do
      oystercard.top_up(top_up_amount)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'reduces the balance by minimum fare' do
      oystercard.top_up(top_up_amount)
      oystercard.touch_in(station)
      expect{oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MIN_FARE)
    end

    it 'forgets entry station on touch out' do
      oystercard.top_up(top_up_amount)
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end

end
