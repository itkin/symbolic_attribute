# SymbolicAttribute

Ruby on Rails ActiveRecord helper to deal with constants stored in database

Add a `symoblic_attribute` method to ActiveRecord::Base, which
- overrides the instance attribute getter to symbolize its value
- if a `:values` option key is passed with an array as value, it defines a class attribute `attribute_name.pluralize` which stores the available attribute values and validates the inclusion of any new instance attribute value within this same array

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

`symoblic_attribute(attr_name, options)`
- `attribute_name` (String) 
- `options` (String)
    - `:values` (Array): list the available attribute values, will be stored in a `attribute_name.pluralize` class attribute
    - other hash keys and values are passed to `validates attribute_name` method, usefull to set some conditional validation (refer to the example bellow)

```ruby

class Participation < ActiveRecord::Base
  symbolic_attribute :role, 
    values: %i{buyer seller}, 
    allow_nil: true
end

#Outside ActiveRecord, we need to implement an attribute accessor and the read_attribute method used by ActiveModel::Validation 
class Participation 
  symbolic_attribute :role, 
    values: %i{buyer seller}, 
    allow_nil: true
    
    
  attr_accessor :role

  def read_attribute(attr)
    instance_variable_get :"@#{attr}"
  end
    
end


Participation.roles
> [:buyer, :seller]

participation = Participation.new

participation.save
> true

participation.role = "foo"

participation.save
> false

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/symbolic_attribute. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

