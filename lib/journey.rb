class Journey

  attr_reader :origin, :destination

  def initialize
    @origin = nil
    @destination = nil
  end 

  def start(entry_station)
    @origin = entry_station
  end


  def finish(exit_station)
    @destination = exit_station
  end

  def fare
    if [@origin, @destination].include? nil
          -6
    else
      2
    end
  end
end
