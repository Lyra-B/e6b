require 'minitest/autorun'
require './e6b_b'

class E6BTest < MiniTest::Test

  describe "Fuel Calculations" do
    describe "Fuel Consumption" do
      before do
        @total_gallons_burned = 50
        @hours = 7
        @minutes = 10
      end

      it "should calculate the gallons per hour as 6.98" do
        assert_equal 6.98, Aircraft.fuel_consumption(50,7,10)
      end
    end

    describe "Flight Time Left" do
      before do
        @gallons_burned_per_hour = 15
        @gallons_left = 60
      end

      it "should calculate the total time the aircraft can fly as 4 hours" do
        assert_equal 4, (@gallons_left/@gallons_burned_per_hour)
      end
    end
  end

  describe "Speed / Distance calculations" do
    describe "True Airspeed" do
      before do
        @altitude = 7000
        @air_pressure_hectopascals = 1013.25
        @air_speed_knots = 60
      end

      it "should calculate the true airspeed as 68.38" do
        assert_equal 68.37, Aircraft.true_air_speed(7000, 60)
      end
    end

    describe "Wind direction" do
      before do
        @runway_heading_degrees = 30
        @wind_direction_degrees = 9
        @wind_speed_kph = 40
      end

      it "should calculate the left/x wind as 14" do
        assert_equal 14, Aircraft.wind_direction(30, 9, 40)
      end

      it "should calculate the headwind as 37" do
        assert_equal 37, Aircraft.headwind(30, 9, 40)
      end
    end
  end

end



