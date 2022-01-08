#!/usr/bin/env ruby

require_relative "../config/environment.rb"

options = {}

parser = OptionParser.new do |opt|
    opt.banner = "Moonology: the moon phase application. Here's how to use it [options]".colorize(:color => :white, :background => :cyan)

    opt.on("-s", "--single", "Will return the moon phase on a single date") do |single|
        options[:single] = single
    end

    opt.on("-n", "--name", "Will return the corresponding moon name on a single date e.g. 2021-12-21") do |name|
        options[:name] = name
    end

    opt.on("-x", "--distance", "Will return the distance of the moon to the Earth on a single date") do |distance|
        options[:distance] = distance
    end

    opt.on("-y", "--sun_distance", "Will return the distance of the moon to the Sun on a single date") do |sun_distance|
        options[:sun_distance] = sun_distance
    end

    # make date a required option
    opt.on("-d", "--date=DATE", "*** Required, specifify the date e.g. 2021-12-21 ***") do |date_string|
        options[:date] = date_string
    end

    # including a help option
    opt.on("-h", "--help", "Will return the help options") do
        puts opt
        exit
    end
end

begin
    parser.parse!

    if !options[:single].nil?
        if options.key?(:sun_distance) || options.key?(:name) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Name or distance or sun-distance options cannot go with single date option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy-mm-dd format")
        end

        moonphase = APIClient.get_moon_phase(options[:date])
        moonphase.each do |a|
            phase = a["Phase"]
            moon = a["Moon"]
            puts moon
            puts "The moon phase is:"
            puts "#{phase}"
        end

    elsif !options[:sun_distance].nil?
        if options.key?(:single) || options.key?(:name) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Single, name or distance options cannot go with sun-distance option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy-mm-dd format")
        end

        moonphase = APIClient.get_moon_phase(options[:date])
        moonphase.each do |a|
            moon = a["Moon"]
            sun_distance = a["DistanceToSun"]
            puts moon
            puts "The distance to the Sun is:"
            puts "#{sun_distance}"
        end

    elsif !options[:name].nil?
        if options.key?(:single) || options.key?(:sun_distance) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Single, sun-distance or distance options cannot go with name option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy-mm-dd format")
        end

        moonphase = APIClient.get_moon_phase(options[:date])
        moonphase.each do |a|
            moon = a["Moon"]
            puts "The moon name is:"
            puts moon
        end
    
    elsif !options[:distance].nil?
        if options.key?(:single) || options.key?(:sun_distance) || options.key?(:name)
            raise OptionParser::InvalidArgument.new("Single, sun-distance or name options cannot go with distance option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy-mm-dd format")
        end

        moonphase = APIClient.get_moon_phase(options[:date])
        moonphase.each do |a|
            distance = a["Distance"]
            moon = a["Moon"]
            puts moon
            puts "The distance to Earth is:"
            puts "#{distance}"
        end

    end


rescue OptionParser::InvalidArgument => e
    STDERR.puts %Q[#{e.message.capitalize}. Run"#{File.basename($0)}" --help for details.]
    exit 1

rescue OptionParser::InvalidOption => e
    STDERR.puts %Q[#{e.message.capitalize}. Run"#{File.basename($0)}" --help for details.]
    exit 2

rescue OptionParser::MissingArgument => e
    STDERR.puts %Q[#{e.message.capitalize}. Run"#{File.basename($0)}" --help for details.]
    exit 3
end


