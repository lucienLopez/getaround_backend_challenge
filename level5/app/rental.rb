require_relative './payroll'
require 'date'

class Rental
  AVAILABLE_OPTIONS = %w[gps baby_seat additional_insurance].freeze

  attr_accessor :car, :payroll, :id, :start_date, :end_date, :distance, :options

  def self.initialize_from_hash(rental_hash, options, cars)
    %w[id car_id start_date end_date distance].each do |key|
      raise "Missing data: #{key}" unless rental_hash[key]
    end
    start_date = Date.parse(rental_hash['start_date'])
    end_date = Date.parse(rental_hash['end_date'])

    rental_car = cars.find { |car| car.id == rental_hash['car_id'] }
    raise "couldn't find car" unless rental_car

    new(
      id: rental_hash['id'], car: rental_car, start_date: start_date, end_date: end_date,
      distance: rental_hash['distance'], options: options & AVAILABLE_OPTIONS
    )
  end

  def initialize(id:, car:, start_date:, end_date:, distance:, options: [])
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance
    @options = options

    @payroll = Payroll.new(rental: self)
  end

  def duration
    @duration ||= end_date - start_date + 1
  end

  def to_h
    {
      id: id,
      options: options,
      actions: [
        { who: :driver, type: :debit, amount: payroll.driver_price },
        { who: :owner, type: :credit, amount: payroll.owner_pay },
        { who: :insurance, type: :credit, amount: payroll.insurance_fee },
        { who: :assistance, type: :credit, amount: payroll.assistance_fee },
        { who: :drivy, type: :credit, amount: payroll.drivy_fee }
      ]
    }
  end
end
