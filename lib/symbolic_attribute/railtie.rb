module SymbolicAttribute
  class Railtie < Rails::Railtie
    initializer 'symbolic_attribute.activerecord' do
      ActiveRecord::Base.send :include, Concern
    end
  end
end