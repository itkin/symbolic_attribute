# SymbolicAttribute

Override the accessor of a given attribute, in order to convert its value from string to symbol when fetched from db
Allow validation check 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'symbolic_attribute'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install symbolic_attribute

## Usage

```ruby

class Participation
  symoblic_attribute :role, choices: %i{buyer seller}, can_change: false    
end

Participation.available_roles
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/symbolic_attribute. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

