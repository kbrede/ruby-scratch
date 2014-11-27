#!/usr/bin/ruby -w

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Converts Fahrenheit to Celsius and Celsius to Fahrenheit.\nUsage: temp_convert.rb [options]"

  opts.on('-f', '--f2c number', Float, "Example: #{$0} -f 32") do |f|
    options[:fopt] = f
  end

  opts.on('-c', '--c2f number', Float, "Example: #{$0} -c 0") do |c|
    options[:copt] = c
  end

  # if no args, print help
  if ARGV.length == 0
    puts opts
    exit
  end
  
  # method to check if string is numerical
  class String
    def is_number?
      true if Float(self) rescue false
    end
  end

  # check if second arg is a number
  num = ARGV[1]
  unless num.is_number?
    puts opts
    exit
  end

  # handle rest of errors
  begin opts.parse! ARGV
  rescue OptionParser::InvalidOption => err
    puts err
    puts opts
    exit 1
  rescue OptionParser::MissingArgument => err
    puts err
    puts opts
    exit 1
  rescue OptionParser::InvalidArgument => err
    puts err
    puts opts
    exit 1
  end
 
  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
  
end.parse!

# set temperature variables
ftemp = options[:fopt]
ctemp = options[:copt]

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
