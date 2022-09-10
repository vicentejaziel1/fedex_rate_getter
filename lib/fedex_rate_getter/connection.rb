require 'faraday'

module FedexRateGetter
	class Connection
		API_URL = 'https://wsbeta.fedex.com:443/xml'

		attr_accessor :api_connection

		def initialize
			@api_connection = Faraday.new(API_URL)
		end

		def get_rates(body)
			api_connection.post(API_URL, body, 'Content-Type' => 'application/xml')
		end
	end
end