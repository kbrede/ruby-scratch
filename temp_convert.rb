#!/usr/bin/ruby -w

require 'optparse'

# ToDo: possibly combine 2 methods into 1 
# deduplicate Interger conversion

# print help if number of options not correct
if ARGV.length <= 1
  ARGV << '-h'
  ARGV[1] = '-h'
end

# print help if second arg isn't a number
unless ARGV[1].match(/[0-9]/)
  ARGV << '-h'
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Converts Fahrenheit to Celsius and Celsius to Fahrenheit.\nUsage: temp_convert.rb [options]"

  opts.on('-f', '--f2c number',  "Example: #{$0} -f 32") do |f|
    options[:fopt] = f
  end

  opts.on('-c', '--c2f number',  "Example: #{$0} -c 0") do |c|
    options[:copt] = c
  end

  # print help message if incorrect option
  begin opts.parse! ARGV
  rescue OptionParser::InvalidOption => invalid_opt
    puts invalid_opt
    puts opts
    exit 1
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end.parse!

# convert temperature to a float
ftemp = options[:fopt]
ftemp = Float(ftemp) if ftemp != nil
ctemp = options[:copt]
ctemp = Float(ctemp) if ctemp != nil

# convert Fahrenheit to Celsius
def ftoc(ftemp)
  temp_celsius = (ftemp - 32) * 0.5556
  puts "#{ftemp}F = #{temp_celsius.round(2)}C"
end

# convert Celsius to Fahrenheit
def ctof(ctemp)
  temp_fahrenheit = (ctemp * 1.8) + 32
  puts "#{ctemp}C = #{temp_fahrenheit.round(2)}F"
end

# call correct method
if options.has_key?(:fopt)
  ftoc(ftemp)
else
  ctof(ctemp)
end
