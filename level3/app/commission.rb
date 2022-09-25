class Commission
  attr_accessor :rental, :total_commission

  def initialize(rental:)
    @rental = rental
  end

  def insurance_fee
    @insurance_fee ||= (total_fee * 0.5).round
  end

  def assistance_fee
    @assistance_fee ||= (rental.duration * 100).to_i
  end

  def drivy_fee
    @drivy_fee ||= total_fee - insurance_fee - assistance_fee
  end

  def to_h
    { insurance_fee: insurance_fee, assistance_fee: assistance_fee, drivy_fee: drivy_fee }
  end

  private

  def total_fee
    @total_fee ||= (rental.price * 0.3).round
  end
end
