class Payroll
  attr_accessor :rental, :total_commission

  def initialize(rental:)
    @rental = rental
  end

  def driver_price
    basic_price + options_price
  end

  def owner_pay
    (basic_price - total_fee + owner_paying_options).to_i
  end

  def insurance_fee
    (total_fee * 0.5).round
  end

  def assistance_fee
    (rental.duration * 100).to_i
  end

  def drivy_fee
    remaining_money = total_fee - insurance_fee - assistance_fee
    remaining_money = remaining_money.positive? ? remaining_money : 0
    remaining_money + drivy_paying_options
  end

  private

  # price ignoring options
  # TODO: find a better name
  def basic_price
    @basic_price ||= (rental.car.price_per_km * rental.distance + duration_pricing).round
  end

  def options_price
    owner_paying_options + drivy_paying_options
  end

  def owner_paying_options
    return @owner_paying_options if @owner_paying_options

    @owner_paying_options = 0
    @owner_paying_options += (500 * rental.duration).to_i if rental.options.include?('gps')
    @owner_paying_options += (200 * rental.duration).to_i if rental.options.include?('baby_seat')
    @owner_paying_options
  end

  def drivy_paying_options
    @drivy_paying_options ||= rental.options.include?('additional_insurance') ? (1000 * rental.duration).to_i : 0
  end

  def total_fee
    @total_fee ||= (basic_price * 0.3).round
  end

  def duration_pricing
    weighed_duration = 1
    weighed_duration += [3, rental.duration - 1].min * 0.9 if rental.duration > 1
    weighed_duration += [6, rental.duration - 4].min * 0.7 if rental.duration > 4
    weighed_duration += (rental.duration - 10) * 0.5 if rental.duration > 10

    rental.car.price_per_day * weighed_duration
  end
end
