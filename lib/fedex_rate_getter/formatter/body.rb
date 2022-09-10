require 'libxml'

module FedexRateGetter
	module Formatter
		class Body
			attr_accessor :body

			def initialize(credentials, quote_params)
				@body = build_body(credentials, quote_params)
			end

			private

			# Creates an XML as requested by the FedEx Api based on the given params
			# @params {JSon} credentials, quote_params
			def build_body(credentials, quote_params)
				doc = create_doc

				format_credentials(doc, credentials)
				format_params(doc, quote_params)

				doc.root.to_s
			end


			def format_credentials(doc, credentials)
				# root
				doc.root << (auth = create_node('WebAuthenticationDetail'))
				doc.root << (client = create_node('ClientDetail'))
				doc.root << (version = create_node('Version'))

				# auth
				auth << (user = create_node('UserCredential'))
				user << create_node('Key', credentials[:user_credential][:key])
				user << create_node('Password', credentials[:user_credential][:password])

				# client
				client << create_node('AccountNumber', credentials[:client_detail][:account_number])
				client << create_node('MeterNumber', credentials[:client_detail][:metter_number])
				client << (local = create_node('Localization'))
				local << create_node('LanguageCode', credentials[:client_detail][:language_code].downcase)
				local << create_node('LocaleCode', credentials[:client_detail][:locale_code].downcase)

				# version
				version << create_node('ServiceId', 'crs')
				version << create_node('Major', 13)
				version << create_node('Intermediate', 0)
				version << create_node('Minor', 0)
			end

			def format_params(doc, quote_params)		
				# root
				doc.root << create_node('ReturnTransitAndCommit', true)
				doc.root << (request = create_node('RequestedShipment'))

				request << create_node('DropoffType', 'REGULAR_PICKUP')
				request << create_node('PackagingType', 'YOUR_PACKAGING')
				request << (shipper = create_node('Shipper'))
				request << (recipient = create_node('Recipient'))

				# shipper
				shipper << (ship_address = create_node('Address'))
				ship_address << create_node('StreetLines', quote_params[:address_from][:street_lines]&.upcase)
				ship_address << create_node('City', quote_params[:address_from][:city]&.upcase)
				ship_address << create_node('StateOrProvinceCode', 'XX')
				ship_address << create_node('PostalCode', quote_params[:address_from][:zip])
				ship_address << create_node('CountryCode', quote_params[:address_from][:country]&.upcase)


				# recipient
				recipient << (recip_address = create_node('Address'))
				recip_address << create_node('StreetLines', quote_params[:address_to][:street_lines]&.upcase)
				recip_address << create_node('City', quote_params[:address_to][:city]&.upcase)
				recip_address << create_node('StateOrProvinceCode', 'XX')
				recip_address << create_node('PostalCode', quote_params[:address_to][:zip])
				recip_address << create_node('CountryCode', quote_params[:address_to][:country]&.upcase)
				recip_address << create_node('Residential', false)

				# shipping info
				request << (ship_charges = create_node('ShippingChargesPayment'))
				ship_charges << create_node('PaymentType', 'SENDER')
				request << create_node('RateRequestTypes', 'ACCOUNT')
				request << create_node('PackageCount', 1)

				# parcel
				request << (parcel = create_node('RequestedPackageLineItems'))
				parcel << create_node('GroupPackageCount', 1)

				parcel << (weight = create_node('Weight'))
				weight << create_node('Units', quote_params[:parcel][:mass_unit]&.upcase)
				weight << create_node('Value', quote_params[:parcel][:weight])

				parcel << (dim = create_node('Dimensions'))
				dim << create_node('Length', quote_params[:parcel][:length]&.to_i)
				dim << create_node('Width', quote_params[:parcel][:width]&.to_i)
				dim << create_node('Height', quote_params[:parcel][:height]&.to_i)
				dim << create_node('Units', quote_params[:parcel][:distance_unit]&.upcase)
			end

			# Creates one node to the xml to be inserted
			# @param {String} name of the node
			# @param {String,Numeric,Boolean} value of the node
			# @return [LibXML::XML::Node]
			def create_node(name, value = nil)
				node = LibXML::XML::Node.new(name)
	    	node.content = value.nil? ? '' : value.to_s

	    	node
			end

			# Creates the xml document
			# @return[LibXML::XML::Document] doc 
			def create_doc
				doc = LibXML::XML::Document.new
	    	doc.root = LibXML::XML::Node.new('RateRequest')
	    	LibXML::XML::Attr.new(doc.root, 'xmlns', 'http://fedex.com/ws/rate/v13')
	    	
	    	doc
			end
		end
	end
end