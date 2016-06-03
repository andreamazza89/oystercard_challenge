#calculates fares
class Tfl

  def self.fare(journey)
    if journey.complete?
      MIN_FARE
    else
      PENALTY_FARE
    end 
  end

private

  MIN_FARE = 1
  PENALTY_FARE = 6

end
