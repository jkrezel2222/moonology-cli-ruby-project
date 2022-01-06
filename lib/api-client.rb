class APIClient

    def self.get_moon_phase(date_string)
        unix_time = DateTime.parse(date_string).to_time.to_i

        uri = URI("https://api.farmsense.net/v1/moonphases/?d=#{unix_time}")

        begin
            response = Net::HTTP.get_response(uri)
            JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)

        rescue StandardError
            puts "An error has been received from the API"
        end
    end


    # def self.get_multiple_phases(date_one, date_two, date_three)
    #     date_one = Date.parse.to_time.to_i
    #     date_two = Date.parse.to_time.to_i
    #     date_three = Date.parse.to_time.to_i

    #     puts date_one
    #     puts date_two
    #     puts date_three

    #     uri = URI("http://api.farmsense.net/v1/moonphases/?d[]=#{date_one}&d[]=#{date_two}&d[]=#{date_three}")
    #     begin
    #         response = Net::HTTP.get_response(uri)
    #         JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)

    #     rescue StandardError
    #         puts "An error has been received from the API"
    #     end
    # end
end

