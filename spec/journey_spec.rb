describe Journey do
  let(:entry_station) { double :station}
  let(:exit_station) {double(:station)}

  describe ':new' do 
    it 'contains the start of the journey' do
      subject.start(entry_station)
      expect(subject.origin).to eq entry_station 
    end 

    it 'contains the end of the journey' do
      subject.finish(exit_station)
      expect(subject.destination).to eq exit_station
    end 
  end

  describe '#fare' do
    it 'returns penalty fare when origin is nil' do
      subject.finish(exit_station)
      expect(subject.fare).to eq -6
    end 

    it 'returns penalty fare when destination is nil' do
      subject.start(entry_station)
      expect(subject.fare).to eq -6
    end 

    it 'returns the cost of the trip fare when origin/destination are not nil' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.fare).to eq 2 
    end 
  end
end
