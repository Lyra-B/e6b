class Flight
attr_accessor :flight_number, :airline, :from, :from_lat, :from_lng, :to,
 :to_lat, :to_lng, :flight_departure, :speed_kph, :bearing, :aircraft

  def estimated_flight_time
    # Find the estimated flight time- e.g. If an aircraft is flying at a speed of per hour, how long will it take to fly  miles?
    earth_radius_km = 6371

    # Convert the lat / lng from the from / to airports into radians
    from_lat_radians = from_lat * Math::PI / 180
    from_lng_radians = from_lng * Math::PI / 180
    to_lat_radians = to_lat * Math::PI / 180
    to_lng_radians = to_lng * Math::PI / 180

    # Calculate the distance between the start and end airports
    cosines_product = Math.cos(to_lat_radians) * Math.cos(from_lat_radians) * Math.cos(from_lng_radians - to_lng_radians)
    sines_product = Math.sin(to_lat_radians) * Math.sin(from_lat_radians)
    distance = earth_radius_km * Math.acos(cosines_product + sines_product)

    # Calculate the flight time
    speed = speed_kph
    hours = (distance / speed).round
    minutes = distance.remainder(speed).round
    return hours, minutes
    #puts "Estimated Flight Time for #{ba_12345[:flight_number]}: #{hours} hours #{minutes} minutes"
  end
end

flight = Flight.new
  flight.flight_number = 'BA-12345',
  flight.airline = 'British Airways',
  flight.from = "LHR",
  flight.from_lat = 51.4700223,
  flight.from_lng = -0.4542955,
  flight.to = "JFK",
  flight.to_lat = 40.6413111,
  flight.to_lng = -73.77813909999999,
  flight.flight_departure = Time.utc(2014, 11, 1, 14, 47),
  flight.speed_kph = 790,
  flight.bearing = 3,
  flight.aircraft = "Boeing 747"

hours, minutes = flight.estimated_flight_time
puts "Estimated Flight Time for #{flight.flight_number}: #{hours} hours #{minutes} minutes"



