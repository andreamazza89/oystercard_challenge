require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:top_up_amount) {Oystercard::MIN_FARE + 1}
  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}
  let(:max_balance) {Oystercard::MAX_BALANCE}
  let(:oyster_with_money) do
    oystercard.top_up(top_up_amount)
    oystercard.touch_in(entry_station)
  end


  describe '#balance' do
    it 'allows user to see starting balance of zero' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up oystercard' do
  		expect{oystercard.top_up(top_up_amount)}.to change{oystercard.balance}.by top_up_amount
  	end

    it 'raises an error if balance exceeds max limit' do
      oystercard.top_up(max_balance)
      message = "Balance can not exceed £#{max_balance}"
      expect{oystercard.top_up(Oystercard::MIN_BALANCE)}.to raise_error message
    end
  end

  describe '#in_journey?' do
    it 'reports when oystercard is in use' do
      oyster_with_money
      expect(oystercard.in_journey?).to eq true
    end

    it 'reports when oystercard is not in use' do
      oyster_with_money
      oystercard.touch_out(exit_station)
      expect(oystercard.in_journey?).to eq false
    end

    it 'reports initialized oystercard not in use' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'raises an error if the balance is insufficient' do
      message = "Insufficient balance"
      expect{ oystercard.touch_in(entry_station)}.to raise_error message
    end

    it 'remembers entry station' do
      oyster_with_money
      expect(oystercard.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do

    it 'stores exit station' do
      oyster_with_money
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
    end

    it 'reduces the balance by minimum fare' do
      oyster_with_money
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::MIN_FARE)
    end

    it 'forgets entry station on touch out' do
      oyster_with_money
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end
  end
  describe "#journeys" do
    context "when first journey ends" do
      it "returns journey made" do
        journeys = [[entry_station,exit_station]]
        oyster_with_money
        oystercard.touch_out(exit_station)
        expect(oystercard.journeys).to eq journeys
      end
    end
    context "when initialised" do
      it "is empty" do
        expect(oystercard.journeys).to be_empty
      end
    end
  end
end
