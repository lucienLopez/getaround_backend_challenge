class Car
  attr_accessor :id, :price_per_day, :price_per_km

  def self.initialize_from_hash(car_hash)
    %w[id price_per_day price_per_km].each do |key|
      raise "Missing data: #{key}" unless car_hash[key]
    end

    new(id: car_hash['id'], price_per_day: car_hash['price_per_day'], price_per_km: car_hash['price_per_km'])
  end

  def initialize(id:, price_per_day:, price_per_km:)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end
end
