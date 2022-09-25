class Commission
  attr_accessor :rental, :total_commission

  def initialize(rental:)
    @rental = rental
  end

  def total_fee
    @total_fee ||= (rental.price * 0.3).round
  end

  def insurance_fee
    @insurance_fee ||= (total_fee * 0.5).round
  end

  def assistance_fee
    @assistance_fee ||= (rental.duration * 100).to_i
  end

  def drivy_fee
    @drivy_fee ||= compute_drivy_fee
  end

  private

  def compute_drivy_fee
    remaining_money = total_fee - insurance_fee - assistance_fee
    remaining_money > 0 ? remaining_money : 0
  end
end
