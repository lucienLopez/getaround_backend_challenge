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
      rentals << Rental.initialize_from_hash(rental_hash, rental_options(rental_hash['id'], data), cars)
    end
  end

  def rental_options(rental_id, data)
    options = []
    data['options'].filter { |option_hash| option_hash['rental_id'] == rental_id }
                   .map { |option_hash| option_hash['type'] }
  end

  def export_data
    output = { rentals: rentals.map(&:to_h) }
    File.write('./data/output.json', "#{JSON.pretty_generate(output)}\n")
  end
end
