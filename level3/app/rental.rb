require_relative './commission'
require 'date'

class Rental
  attr_accessor :car, :commission, :id, :start_date, :end_date, :distance

  def self.initialize_from_hash(rental_hash, cars)
    %w[id car_id start_date end_date distance].each do |key|
      raise "Missing data: #{key}" unless rental_hash[key]
    end
    start_date = Date.parse(rental_hash['start_date'])
    end_date = Date.parse(rental_hash['end_date'])

    rental_car = cars.find { |car| car.id == rental_hash['car_id'] }
    raise "couldn't find car" unless rental_car

    new(
      id: rental_hash['id'], car: rental_car, start_date: start_date, end_date: end_date,
      distance: rental_hash['distance']
    )
  end

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance

    @commission = Commission.new(rental: self)
  end

  def duration
    @duration ||= end_date - start_date + 1
  end

  def price
    @price ||= (car.price_per_km * distance + duration_pricing).round
  end

  def to_h
    { id: id, price: price, commission: commission.to_h }
  end

  private

  def duration_pricing
    weighed_duration = 1
    weighed_duration += [3, duration - 1].min * 0.9 if duration > 1
    weighed_duration += [6, duration - 4].min * 0.7 if duration > 4
    weighed_duration += (duration - 10) * 0.5 if duration > 10

    car.price_per_day * weighed_duration
  end
end
