class Oystercard

  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    fail "Balance can not exceed £#{MAX_BALANCE}" if balance + amount > MAX_BALANCE
  	@balance += amount
  end

  def deduct(amount)
  	@balance -= amount
  end

  def touch_in(station)
    raise "Insufficient balance" if balance < MIN_BALANCE
    @entry_station = station
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

    private :deduct

end
