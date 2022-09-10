RSpec.describe FedexRateGetter do
  it "has a version number" do
    expect(FedexRateGetter::VERSION).not_to be nil
  end

  it "does something useful" do
        quote_params = {
        address_from: {
               zip: "64000",
           country: "MX"
        },
        address_to: {
           zip: "64000",
           country: "MX"
        },
        parcel: {
           length: 25,
           width: 28,
           height: 46.0,
           distance_unit: "cm",
           weight: 6.5,
           mass_unit: "kg"
        } 
    }

    credentials = {
        user_credential: {
            key: 'bkjIgUhxdghtLw9L',
            password: '6p8oOccHmDwuJZCyJs44wQ0Iw'
        },
        client_detail: {
            account_number: '510087720',
            metter_number: '119238439',
            language_code: 'es',
            locale_code: 'mx'
        }
    }

    x = FedexRateGetter::Rate.get(credentials, quote_params)
    
    expect(x.class.name).to eq 'Array'
  end
end
