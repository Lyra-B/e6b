class Aircraft
  def self.fuel_consumption(total_gallons_burned, hours, minutes)
  	(total_gallons_burned / (hours+(minutes/60.to_f))).round(2)
  end

  def self.time_left(gallons_burned_per_hour, gallons_left)
  	gallons_left/gallons_burned_per_hour
  end
  
  module Pressure
  	AIR_PRESS_HECT = 1013.25
  	MODIFIER = 30
  end

  def self.true_air_speed(alt, air_speed_knots)
  	real_air_press= Pressure::AIR_PRESS_HECT-(alt / Pressure::MODIFIER)
    (air_speed_knots * Math.sqrt((Pressure::AIR_PRESS_HECT)/(real_air_press))).round(2)
  end

  def self.wind_direction(runway_heading_degrees, wind_direction_degrees, wind_speed_kph)
  	difference = (runway_heading_degrees - wind_direction_degrees).abs
  	a = difference * Math::PI/180
  	(wind_speed_kph * Math.sin(a)).round
  end

  def self.headwind(runway_heading_degrees, wind_direction_degrees, wind_speed_kph)
  	difference = (runway_heading_degrees - wind_direction_degrees).abs
  	a = difference * Math::PI/180
  	(wind_speed_kph * Math.cos(a)).round
  end
end


