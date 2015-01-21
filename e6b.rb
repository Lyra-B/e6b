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
end

class Airport
  attr_accessor :code, :lat_lng

  def distance_to(other_airport)
    earth_radius_km = 6371
    from_lat_radians, from_lng_radians = lat_lng.to_radians
    to_lat_radians, to_lng_radians = other_airport.lat_lng.to_radians
    # from_lat_radians = @lat * Math::PI / 180
    # from_lng_radians = @lng * Math::PI / 180
    # to_lat_radians = other_airport.lat * Math::PI / 180
    # to_lng_radians = other_airport.lng * Math::PI / 180
    cosines_product = Math.cos(to_lat_radians) * Math.cos(from_lat_radians) * Math.cos(from_lng_radians - to_lng_radians)
    sines_product = Math.sin(to_lat_radians) * Math.sin(from_lat_radians)
    distance = earth_radius_km * Math.acos(cosines_product + sines_product)
  end

  # def lat_as_radians
  #   lat * Math::PI / 180, lng * Math::PI / 180
  # end

end


class Flight
attr_accessor :flight_number , :airline, :from, :to, :flight_departure, 
:speed_kph, :bearing, :aircraft

  def estimated_flight_time
    distance = from.distance_to(to)
    hours = (distance / speed_kph).round
    minutes = distance.remainder(speed_kph).round
    return hours, minutes
  end
end

heathrow = Airport.new
heathrow.code = "LHR"
heathrow.lat_lng = LatLng.new(51.4700223,-0.4542955)

jfk = Airport.new
jfk.code = "JFK"
jfk.lat_lng = LatLng.new(40.6413111, -73.77813909999999)

flight = Flight.new
flight.flight_number = 'BA-12345'
flight.airline = 'British Airways'
flight.from = heathrow
flight.to = jfk
flight.flight_departure = Time.utc(2014, 11, 1, 14, 47)
flight.speed_kph = 790
flight.bearing = 3
flight.aircraft = "Boeing 747"

hours, minutes = flight.estimated_flight_time
puts "Estimated Flight Time for #{flight.flight_number} : #{hours} hours #{minutes} minutes"



