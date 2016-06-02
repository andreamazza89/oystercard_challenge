describe Station do
  let(:station_name) { Station.new('test_station', 2) }
  
  it '#name returns the name of the station' do
    expect(station_name.name).to eq 'test_station'
  end 

  it '#zone returns the zone of the station' do
    expect(station_name.zone).to eq 2
  end 
end
