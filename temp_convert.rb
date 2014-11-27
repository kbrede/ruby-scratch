#!/usr/bin/ruby -w

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Converts Fahrenheit to Celsius and Celsius to Fahrenheit.\nUsage: temp_convert.rb [options]"

  opts.on('-f', '--f2c number', Float, "Example: #{$0} -f 32") do |f|
    @temp = options[:fopt] = f
  end

  opts.on('-c', '--c2f number', Float, "Example: #{$0} -c 0") do |c|
    @temp = options[:copt] = c
  end

  # if no args, print help
  if ARGV.length <= 1
    puts opts
    exit 1
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
    exit 1
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

# grab key and convert to string
temp_option = options.keys.first.to_s
# set temperature var
temp = @temp

# temperature convert function
def convert_temp(temp_option, temp)
  if temp_option == "fopt"
    # convert Fahrenheit to Celsius
    temp_celsius = (temp - 32) * 0.5556
    puts "#{temp}F = #{temp_celsius.round(2)}C"
  else
    # convert Celsius to Fahrenheit
    temp_fahrenheit = (temp * 1.8) + 32
    puts "#{temp}C = #{temp_fahrenheit.round(2)}F"
  end
end

convert_temp(temp_option, temp)
