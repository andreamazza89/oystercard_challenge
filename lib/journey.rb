class Journey
  
  def complete?
    @in && @out 
  end

  def start(station)
    @in = station
  end 

  def finish(station)
    @out = station
  end 

end
