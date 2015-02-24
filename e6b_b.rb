module Pressure
	AIR_PRESS_HECT = 1013.25
	MODIFIER = 30
end

class Flight
	attr_accessor :runway_heading_degrees, :hours, :minutes, :altitude, :aircraft, :wind_conditions

	include Pressure

  def initialize (options={})
		options.each{|key,value|
			self.send("#{key}=", value)
		}
	end

	def time_left
  	self.aircraft.gallons_left / self.aircraft.gallons_burned_per_hour
  end

  def fuel_consumption
  	self.aircraft.fuel_consumption(self.hours, self.minutes)
  end

  def true_air_speed
  	self.aircraft.true_air_speed(self.altitude)
  end

  def wind_direction
  	self.wind_conditions.wind_direction
  end

  def headwind
  	self.wind_conditions.headwind
  end
end

class Wind
	attr_accessor :wind_direction_degrees, :wind_speed_kph, :flight

	def heading_difference (runway_heading_degrees)
	  (runway_heading_degrees - self.wind_direction_degrees).abs * Math::PI/180
  end

	def wind_direction
		# heading_difference = heading_difference(runway_heading_degrees, self.wind_direction_degrees)
  	(self.wind_speed_kph * Math.sin(heading_difference(self.flight.runway_heading_degrees))).round
  end

  def headwind
  	# heading_difference = heading_difference(runway_heading_degrees, self.wind_direction_degrees)
  	(self.wind_speed_kph * Math.cos(heading_difference(self.flight.runway_heading_degrees))).round
  end
end

class Aircraft
	attr_accessor :gallons_burned_per_hour, :air_speed_knots, :gallons_left, :total_gallons_burned

	def fuel_consumption(hours, minutes)
  	min_to_h = minutes/60.to_f
  	hours_plus_min = hours+min_to_h
  	(self.total_gallons_burned / hours_plus_min).round(2)
  end

  def true_air_speed(altitude)
  	real_air_press= Pressure::AIR_PRESS_HECT-(altitude / Pressure::MODIFIER)
    (self.air_speed_knots * Math.sqrt((Pressure::AIR_PRESS_HECT)/(real_air_press))).round(2)
  end
end


