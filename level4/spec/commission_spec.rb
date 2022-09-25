require 'minitest/autorun'

require_relative '../app/car'
require_relative '../app/commission'
require_relative '../app/rental'
require 'date'

describe Commission do
  before do
    @car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    @rental = Rental.new(
      id: 1, car: @car, start_date: Date.parse('2015-03-31'), end_date: Date.parse('2015-04-01'),
      distance: 300
    )
    @commission = Commission.new(rental: @rental)
  end

  describe '#insurance_fee' do
    it 'computes correctly' do
      _(@commission.insurance_fee).must_equal 1020
    end
  end

  describe '#assistance_fee' do
    it 'computes correctly' do
      _(@commission.assistance_fee).must_equal 200
    end
  end

  describe '#drivy_fee' do
    it 'computes correctly' do
      _(@commission.drivy_fee).must_equal 820
    end
  end
end
