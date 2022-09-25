require_relative './car'
require_relative './rental'
require 'json'

class App
  attr_accessor :cars, :rentals

  def initialize
    @cars = []
    @rentals = []
  end

  def run
    data = JSON.parse(File.read('./data/input.json'))
    load_cars(data)
    load_rentals(data)
    export_data
  end

  private

  def load_cars(data)
    data['cars'].each do |car_hash|
      cars << Car.initialize_from_hash(car_hash)
    end
  end

  def load_rentals(data)
    data['rentals'].each do |rental_hash|
      rentals << Rental.initialize_from_hash(rental_hash, cars)
    end
  end

  def export_data
    output = { rentals: rentals.map { |rental| { id: rental.id, price: rental.price } } }
    File.write('./data/output.json', "#{JSON.pretty_generate(output)}\n")
  end
end
