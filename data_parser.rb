require 'csv'

class Delivery
  attr_accessor :destination, :shipped, :number, :money, :pilot, :bonus

  def initialize (destination:, what_got_shipped:, number_of_crates:, money_we_made:)
    @destination=destination
    @shipped=what_got_shipped
    @number=number_of_crates
    @money=money_we_made
    @pilot=change_pilot
    @bonus=bonus_plan
  end

  def change_pilot
      pilot = case destination
              when "Earth" then "Fry"
              when "Mars" then "Amy"
              when "Uranus" then "Bender"
              else "Leela"
              end
  end

  def bonus_plan
    self.money * 0.10
  end

  def pilot?(driver)
    pilot.include? driver
  end

end

class Parse

attr_accessor :file

  def initialize
    @file = []
  end

  def parse_data (file_name)
    CSV.foreach(file_name, headers: true, header_converters: :symbol, converters: :all) do |row|
    @file << Delivery.new(row)
    end
  end

  def trips(driver)
    file.select{|flyist| flyist.pilot==driver}.count
  end
end

csv_file = "planet_express_logs.csv"

tracker=Parse.new
tracker.parse_data(csv_file)
puts tracker.trips("Fry")

# blank_array = []
#
# data = CSV.foreach("planet_express_logs.csv", headers: true, header_converters:
# :symbol, converters: :all) do |row|
#                              blank_array << Delivery.new(row)
#                            end # replace with your logic
#
# sum = blank_array.inject(0){|cash, total| cash + total.money}
#
# puts sum
#
# fry_trips = blank_array.select{|pilot_name| pilot_name.pilot? "Fry"}.collect(&:destination).count
# fry_planet = blank_array.select{|pilot_name| pilot_name.pilot? "Fry"}.collect(&:destination).uniq.join("")
# fry_bonus = blank_array.select{|pilot_name| pilot_name.pilot? "Fry"}.collect(&:bonus).inject(:+)
#
# puts "Fry took #{fry_trips} trips to #{fry_planet} and made #{fry_bonus} in bonus money"
#
# amy_trips = blank_array.select{|pilot_name| pilot_name.pilot? "Amy"}.collect(&:destination).count
# amy_planet = blank_array.select{|pilot_name| pilot_name.pilot? "Amy"}.collect(&:destination).uniq.join("")
# amy_bonus = blank_array.select{|pilot_name| pilot_name.pilot? "Amy"}.collect(&:bonus).inject(:+)
#
# puts "Amy took #{amy_trips} trip to #{amy_planet} and made #{amy_bonus} in bonus money"
#
# bender_trips = blank_array.select{|pilot_name| pilot_name.pilot? "Bender"}.collect(&:destination).count
# bender_planet = blank_array.select{|pilot_name| pilot_name.pilot? "Bender"}.collect(&:destination).uniq.join("")
# bender_bonus = blank_array.select{|pilot_name| pilot_name.pilot? "Bender"}.collect(&:bonus).inject(:+)
#
# puts "Bender took #{bender_trips} trips to #{bender_planet} and made #{bender_bonus} in bonus money"
#
# leela_trips = blank_array.select{|pilot_name| pilot_name.pilot? "Leela"}.collect(&:destination).count
# leela_planet = blank_array.select{|pilot_name| pilot_name.pilot? "Leela"}.collect(&:destination).uniq.join(", ")
# leela_bonus = blank_array.select{|pilot_name| pilot_name.pilot? "Leela"}.collect(&:bonus).inject(:+)
#
# puts "Leela took #{leela_trips} trips to the planets #{leela_planet} and made #{leela_bonus} in bonus money"
#
# #Pilot array
# pilot_array = blank_array.collect(&:pilot).uniq.inspect
# puts pilot_array
#
# puts blank_array.trips("Fry")


#First try at summing total money made
# total_money = []
# CSV.foreach("planet_express_logs.csv", headers: true, header_converters:
# :symbol, converters: :all) do |row|
#   total_money << row[:money_we_made]
# end
#
# puts total_money.inject(0, &:+).inspect
