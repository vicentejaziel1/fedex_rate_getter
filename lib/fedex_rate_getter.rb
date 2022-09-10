require "fedex_rate_getter/version"
require "fedex_rate_getter/connection"
require "fedex_rate_getter/formatter/body"
require "fedex_rate_getter/formatter/response"

module FedexRateGetter
  class Rate
    attr_accessor :something
    
    def initialize
      @something = 'hola mundo'
    end

    # Main method. returns shipping rate
    # @params [Json, Json] credentials, quote_params
    # @return [Array] array of requested rates
    def self.get(credentials, quote_params)
      # enable the api connection
      connection = FedexRateGetter::Connection.new

      # format body
      body = FedexRateGetter::Formatter::Body.new(credentials, quote_params).body

      # make a call to the api
      res = connection.get_rates(body)

      # return
      FedexRateGetter::Formatter::Response.new(res.body).response
    end

    private

  end
end
