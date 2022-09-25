require 'minitest/autorun'

require_relative '../app/car'
require_relative '../app/payroll'
require_relative '../app/rental'
require 'date'

describe Payroll do
  before do
    @car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    @rental = Rental.new(
      id: 1, car: @car, start_date: Date.parse('2015-03-31'), end_date: Date.parse('2015-04-01'),
      distance: 300
    )
    @payroll = Payroll.new(rental: @rental)
  end

  describe '#insurance_fee' do
    it 'computes correctly' do
      _(@payroll.insurance_fee).must_equal 1020
    end
  end

  describe '#assistance_fee' do
    it 'computes correctly' do
      _(@payroll.assistance_fee).must_equal 200
    end
  end

  describe '#drivy_fee' do
    it 'computes correctly' do
      _(@payroll.drivy_fee).must_equal 820
    end
  end
end
