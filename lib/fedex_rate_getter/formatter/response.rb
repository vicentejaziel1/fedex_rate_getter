require 'libxml'
require 'active_support/core_ext/hash'

module FedexRateGetter
	module Formatter
		class Response
			attr_accessor :response, :hashed

			# @Attribute[hashed] hash format extracted directly from fedex api xml
			# @Attribute[response] json format
			def initialize(response)
				@hashed = Hash.from_xml(response)
				@response = transform_response
			end

			private

			# Transforms the xml given by fedex into a more readable hash
			# @return [Array] response. An array with the rates
			def transform_response
				# If it fails will return the hashed response directly from FedExApi
				return error unless hashed['RateReply']['HighestSeverity'] == 'SUCCESS'

				response = hashed['RateReply']['RateReplyDetails'].map do |rate|
					next if rate['ServiceType'].blank?

					details = rate['RatedShipmentDetails'].last['ShipmentRateDetail']['TotalNetChargeWithDutiesAndTaxes']

					{
						price: details['Amount'],
					 	currency: details['Currency'],
					 	service_level: {
					   name: beautify_type(rate['ServiceType']),
					   token: rate['ServiceType'] 
						}
					}
				end

				response.compact
			end

			# Just an error
			def error
				{ error: hashed }
			end

			# Beautify the service type value
			# @param {String} HELLO_WORLD
			# @return [String] Hello world
			def beautify_type(type)
				type.gsub('_',' ').capitalize	
			end
		end
	end
end