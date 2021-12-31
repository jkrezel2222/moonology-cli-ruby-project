#!/usr/bin/env ruby

require_relative "../config/environment.rb"

options = {}

parser = OptionParser.new do |opt|
    opt.banner = "How to use moonology-run |options|"

    opt.on("-s", "--single", "Will return the moon phase on a single date") do |single|
        options[:single] = single
    end

    opt.on("-r", "--range", "Will return the moon phases within a date range") do |range|
        options[:range] = range
    end

    opt.on("-n", "--name", "Will return the corresponding moon name on a single date") do |name|
        options[:name] = name
    end

    opt.on("-di", "--distance", "Will return the distance of the moon to the earth on a single date") do |distance|
        options[:distance] = distance
    end

# adding date as a required argument

    opt.on("-d", "date=DATE", "Specifify the date in ddmmyyyy format", Date) do |date|
        options[:date] = date


    end

    opt.on("-h", "--help", "Will return the help options") do
        puts opt
        exit
    end
end

parser.parse!