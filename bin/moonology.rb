#!/usr/bin/env ruby

require_relative "../config/environment.rb"

options = {}

parser = OptionParser.new do |opt|
    opt.banner = "Moonology: the moon phase application. Here's how to use it [options]"

    opt.on("-s", "--single", "Will return the moon phase on a single date") do |single|
        options[:single] = single
    end

    opt.on("-r", "--range", "Will return the moon phases within a date range") do |range|
        options[:range] = range
    end

    opt.on("-n", "--name", "Will return the corresponding moon name on a single date e.g. 2021-12-21") do |name|
        options[:name] = name
    end

    opt.on("-x", "--distance", "Will return the distance of the moon to the earth on a single date") do |distance|
        options[:distance] = distance
    end

    # make date a required option
    opt.on("-d", "--date=DATE", "*** Specifify the date e.g. 2021-12-21 ***") do |date_string|
        options[:date] = date_string
    end

    # make a date range a required option
    opt.on("-b", "--between=BETWEEN", "*** Specifify the date range in yyyy,dd,mm yyyy,dd,mm yyyy,dd,mm format ***") do |between_string|
        options[:between] = between_string
        # add in argument here
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
        if options.key?(:range) || options.key?(:name) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Range, name or distance options cannot go with single date option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy,mm,dd format")
        end

        moonphase = APIClient.get_moon_phase(options[:date])
        moonphase.each do |a|
            phase = a["Phase"]
            moon = a["Moon"]
            puts moon
            puts "The moon phase is:"
            puts "#{phase}"
        end

    elsif !options[:range].nil?
        if options.key?(:single) || options.key?(:name) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Single, name or distance options cannot go with date range option.")
        end

        if options[:between].nil?
            raise OptionParser::MissingArgument.new("Type in a date range in yyyy,mm,dd yyyy,mm,dd yyyy,mm,dd format")
        end

        # *********** add in here code to call the api for the range date response ***********
        # moonphase = APIClient.get_multiple_phases(options[:range])
        # moonphase.each do |a|
        #     phase = a["Phase"]
        #     moon = a["Moon"]
        #     puts moon
        #     puts "#{phase} phase"
        # end

    elsif !options[:name].nil?
        if options.key?(:single) || options.key?(:range) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Single, date range or distance options cannot go with name option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy,mm,dd format")
        end

        moonphase = APIClient.get_moon_phase(options[:date])
        moonphase.each do |a|
            moon = a["Moon"]
            puts "The moon name is:"
            puts moon
        end
    
    elsif !options[:distance].nil?
        if options.key?(:single) || options.key?(:range) || options.key?(:name)
            raise OptionParser::InvalidArgument.new("Single, date range or name options cannot go with distance option.")
        end

        if options[:date].nil?
            raise OptionParser::MissingArgument.new("You must type in a single date in yyyy,mm,dd format")
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


