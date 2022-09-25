require 'minitest/autorun'

require_relative '../app/car'
require_relative '../app/rental'
require 'date'

describe Rental do
  before do
    @car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
  end

  describe '#price' do
    describe 'with a 2 days duration' do
      before do
        @rental = Rental.new(
          id: 1, car: @car, start_date: Date.parse('2015-03-31'), end_date: Date.parse('2015-04-01'),
          distance: 300
        )
      end

      it 'computes price correctly' do
        _(@rental.price).must_equal 6800
      end
    end

    describe 'with a 11 days duration' do
      before do
        @rental = Rental.new(
          id: 1, car: @car, start_date: Date.parse('2015-07-3'), end_date: Date.parse('2015-07-14'),
          distance: 1000
        )
      end

      it 'computes price correctly' do
        _(@rental.price).must_equal 27_800
      end
    end
  end
end
