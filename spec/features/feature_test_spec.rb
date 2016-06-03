require_relative '../../lib/oystercard'

describe 'Feature test' do 
  let(:my_card) {Oystercard.new}

  it 'OysterCard charges a penalty fare if user touches out without touching in' do
    expect {my_card.touch_out(Station.new(1, 'St. Pancras'))}.to change{my_card.balance}.by(-10)
  end

  it 'OysterCard charges a minimun fare if user touches in then out at different station' do
    my_card.top_up(88)
    my_card.touch_in(Station.new(1,'St pancreas, the pain in the belly'))
    expect {my_card.touch_out(Station.new(1, 'Angie'))}.to change{my_card.balance}.by(-1)
  end 

end 
