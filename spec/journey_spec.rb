describe Journey do
  
  it '#complete? returns false when journey was not started then ended' do
    subject.finish(double :station)  
    expect(subject.complete?).to be_falsey
  end 

  it '#complete? returns false when journey was started but not ended' do
    subject.start(double :station)  
    expect(subject.complete?).to be_falsey
  end 

  it '#complete? returns true when journey was started and ended' do
    subject.start(double :station)  
    subject.finish(double :station)  
    expect(subject.complete?).to be_truthy
  end 

end 
