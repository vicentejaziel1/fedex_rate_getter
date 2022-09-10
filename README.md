## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fedex_rate_getter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fedex_rate_getter

## Usage

```ruby
    require 'fedex_rate_getter'


    FedexRateGetter::Rate.get(credentials, quote_params)
```

These are the correct structures for:

```json

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
            key: 'bkjdkeEWIgUhxdghtLw9L', # api key
            password: '6p8oOccHmDwuJZCyJs44wQ0Iw' # api password
        },
        client_detail: {
            account_number: '510087720', #fedex account number
            metter_number: '119238439', #fedex metter number
            language_code: 'es', # language [es, en, ...]
            locale_code: 'mx' # Country code [mx, usa, ...]
        }
    }
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fedex_rate_getter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/fedex_rate_getter/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FedexRateGetter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fedex_rate_getter/blob/master/CODE_OF_CONDUCT.md).
