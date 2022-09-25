require 'json'
require 'date'

data = JSON.parse(File.read('./data/input.json'))

cars = data['cars']
rentals = data['rentals']
result = { rentals: [] }

rentals.each do |rental|
  rental_car = cars.find { |car| car['id'] == rental['car_id'] }
  raise "couldn't find car" unless rental_car

  duration = (Date.parse(rental['end_date']) - Date.parse(rental['start_date']) + 1).to_i

  result[:rentals] << {
    id: rental['id'],
    price: rental_car['price_per_km'] * rental['distance'] + rental_car['price_per_day'] * duration
  }
end

File.write('./data/output.json', "#{JSON.pretty_generate(result)}\n")
