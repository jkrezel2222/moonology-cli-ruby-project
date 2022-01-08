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
end

