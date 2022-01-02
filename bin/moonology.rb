#!/usr/bin/env ruby

require_relative "../config/environment.rb"

options = {}

parser = OptionParser.new do |opt|
    opt.banner = "Moonology: the moon phase application. Here's how to use it [options]"

    opt.on("-s", "--single", "Will return the moon phase on a single date") do |single|
        options[:single] = single
        puts "working"
    end

    opt.on("-r", "--range", "Will return the moon phases within a date range") do |range|
        options[:range] = range
    end

    opt.on("-n", "--name", "Will return the corresponding moon name on a single date") do |name|
        options[:name] = name
    end

    opt.on("-x", "--distance", "Will return the distance of the moon to the earth on a single date") do |distance|
        options[:distance] = distance
    end

    # make date a required option
    opt.on("-d", "--date=DATE", "Specifify the date in dd-mm-yyyy format", String) do |date_string|
        options[:date] = date_string
        # add in argument here
    end

    # make a date range a required option
    opt.on("-b", "--between=BETWEEN", "Specifify the date range in dd-mm-yyyy - dd-mm-yyyy format", String) do |date_string|
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
            raise OptionParser::MissingArgument.new("You must type in a single date")
        end

        # *********** add in here code to call the api for the single date response ***********
        # *********** add in here code to change the date string to unix datetime stamp format ***********

    elsif !options[:range].nil?
        if options.key?(:single) || options.key?(:name) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Single, name or distance options cannot go with date range option.")
        end

        if options[:between].nil?
            raise OptionParser::MissingArgument.new("You must type in a date range")
        end

        # *********** add in here code to call the api for the range date response ***********

    elsif !options[:name].nil?
        if options.key?(:single) || options.key?(:range) || options.key?(:distance)
            raise OptionParser::InvalidArgument.new("Single, date range or distance options cannot go with name option.")
        end

        # *********** add in here code to call the api for the name response ***********
    
    elsif !options[:distance].nil?
        if options.key?(:single) || options.key?(:range) || options.key?(:name)
            raise OptionParser::InvalidArgument.new("Single, date range or name options cannot go with distance option.")
        end

        # *********** add in here code to call the api for the distance response ***********
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


