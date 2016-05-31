class OysterCard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end 

  def top_up(value)
    fail('Balance limit reached!') if @balance + value > MAX_BALANCE
    @balance += value
  end

end
