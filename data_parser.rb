require 'csv'

class Delivery
  attr_accessor :destination, :shipped, :number, :money, :pilot

  def initialize (destination:, what_got_shipped:, number_of_crates:, money_we_made:)
    @destination=destination
    @shipped=what_got_shipped
    @number=number_of_crates
    @money=money_we_made
    @pilot=change_pilot
  end

  def change_pilot
      pilot = case destination
              when "Earth" then "Fry"
              when "Mars" then "Amy"
              when "Uranus" then "Bender"
              else "Leela"
              end
  end

  def pilot?(driver)
    pilot.include? driver
  end

end


blank_array = []

data = CSV.foreach("planet_express_logs.csv", headers: true, header_converters:
:symbol, converters: :all) do |row|
                             blank_array << Delivery.new(row)
                           end # replace with your logic

puts blank_array.inspect

sum = blank_array.inject(0){|cash, total| cash + total.money}

puts sum

puts blank_array.inspect

fry = blank_array.select{|pilot| pilot.pilot? "Fry"}.collect(&:destination).count

puts "Fry took #{fry} trips"
#First try at summing total money made
# total_money = []
# CSV.foreach("planet_express_logs.csv", headers: true, header_converters:
# :symbol, converters: :all) do |row|
#   total_money << row[:money_we_made]
# end
#
# puts total_money.inject(0, &:+).inspect
