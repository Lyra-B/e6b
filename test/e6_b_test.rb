require 'minitest/autorun'
require_relative '../e6b_b'
require_relative '../e6b'

class E6BTest < MiniTest::Test

  describe "Fuel Calculations" do
    describe "Fuel Consumption" do
      before do
        @flight = Flight.new
        @flight.aircraft = Aircraft.new
        @flight.hours = 7
        @flight.minutes = 10
        @flight.aircraft.total_gallons_burned = 50
      end

      it "should calculate the gallons per hour as 6.98" do
        assert_equal 6.98, @flight.fuel_consumption
      end
    end

    describe "Flight Time Left" do
      before do
        @flight = Flight.new
        @flight.aircraft = Aircraft.new
        @flight.aircraft.gallons_burned_per_hour = 15
        @flight.aircraft.gallons_left = 60
      end

      it "should calculate the total time the aircraft can fly as 4 hours" do
        assert_equal 4, @flight.time_left
      end
    end
  end

  describe "Speed / Distance calculations" do
    describe "True Airspeed" do
      before do
        @flight = Flight.new
        @flight.aircraft = Aircraft.new
        @flight.altitude = 7000
        @flight.aircraft.air_speed_knots = 60
      end

      it "should calculate the true airspeed as 68.38" do
        assert_equal 68.37, @flight.true_air_speed
      end
    end

    describe "Wind direction" do
      before do
        @flight = Flight.new
        @flight.wind_conditions = Wind.new
        @flight.runway_heading_degrees = 30
        @flight.wind_conditions.wind_direction_degrees = 9
        @flight.wind_conditions.wind_speed_kph = 40
        @flight.wind_conditions.flight = @flight
      end

      it "should calculate the left/x wind as 14" do
        assert_equal 14, @flight.wind_direction
      end

      it "should calculate the headwind as 37" do
        assert_equal 37, @flight.headwind
      end
    end
  end

end



