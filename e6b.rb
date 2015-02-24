module HashInitializer
  def initialize(options={})
    options.each do |key,value|
      self.send(:"#{key}=" , value)
    end
  end
end

module Earth
  RADIUS_KM = 6371
end

class LatLng
  attr_accessor :lat, :lng

  def initialize(lat, lng)
    self.lat = lat
    self.lng = lng
  end

  def to_radians
    half_pi = Math::PI / 180
    return lat * half_pi, lng * half_pi
  end

  def distance_to(other_point)
    from_lat_radians, from_lng_radians = self.to_radians
    to_lat_radians, to_lng_radians = other_point.to_radians
    cosines_product = Math.cos(to_lat_radians) * Math.cos(from_lat_radians) * Math.cos(from_lng_radians - to_lng_radians)
    sines_product = Math.sin(to_lat_radians) * Math.sin(from_lat_radians)
    Earth::RADIUS_KM * Math.acos(cosines_product + sines_product)
  end
end

class Airport
  attr_accessor :code, :lat_lng

  def initialize(code,lat_lng)
    self.code = code
    self.lat_lng = lat_lng
  end
end

class Flight
attr_accessor :flight_number , :airline, :from, :to, :flight_departure,
:speed_kph, :bearing, :aircraft, :from_lat_lng, :to_lat_lng
include HashInitializer
  def estimated_flight_time
    distance = from.lat_lng.distance_to(to.lat_lng)
    hours = (distance / speed_kph).round
    minutes = distance.remainder(speed_kph).round
    return hours, minutes
  end

  def print_estimateda_flight_time
    hours, minutes = estimated_flight_time(from.lat_lng, to.lat_lng)
    puts "Estimated Flight Time for #{flight.flight_number} : #{hours} hours #{minutes} minutes"
  end
end

heathrow = Airport.new("LHR", LatLng.new(51.4700223,-0.4542955))
jfk = Airport.new("JFK", LatLng.new(40.6413111, -73.77813909999999))
# heathrow = Airport.new(:code => "LHR", :lat_lng => LatLng.new(51.4700223,-0.4542955))
# jfk = Airport.new(:code => "JFK", :lat_lng => LatLng.new(40.6413111, -73.77813909999999))

@flight = Flight.new(
:flight_number => 'BA-12345',
:airline => 'British Airways',
:from => heathrow,
:to => jfk,
:flight_departure => Time.utc(2014, 11, 1, 14, 47),
:speed_kph => 790,
:bearing => 3,
:aircraft => "Boeing 747"
)





