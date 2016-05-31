class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    fail "Balance can not exceed £#{MAX_BALANCE}" if balance + amount > MAX_BALANCE
  	@balance += amount
  end

  def deduct(amount)
  	@balance -= amount
  end

  def touch_in
    raise "Insufficient balance" if balance < MIN_BALANCE
    @in_journey = true

  end

  def in_journey?
    @in_journey ? true : false
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

    private :deduct


end
