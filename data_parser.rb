#!/usr/bin/env ruby

require 'csv'

file_name = ARGV[0]

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

  def bonus(driver)
    file.select{|flyist| flyist.pilot==driver}.collect(&:bonus).inject(:+)
  end

  def money_by_destination(planet)
    file.select{|place| place.destination==planet}.collect(&:money).inject(:+)
  end

  def planet_tracker(driver)
    file.select{|flyist| flyist.pilot==driver}.collect(&:destination).uniq.join("")
  end
end

csv_file = "planet_express_logs.csv"

tracker=Parse.new
tracker.parse_data(file_name)

profit=tracker.file.collect(&:money).inject(:+)
pilots=tracker.file.collect(&:pilot).uniq
planets=tracker.file.collect(&:destination).uniq

puts "$#{profit}: total money made this week"

pilots.each{|pilot| puts "#{pilot} made #{tracker.trips(pilot)} trips"}
pilots.each{|pilot| puts "#{pilot} made $#{tracker.bonus(pilot)} dollars in bonus"}
planets.each{|planet| puts "#{planet} received $#{tracker.money_by_destination(planet)} dollars in shipments this week"}
