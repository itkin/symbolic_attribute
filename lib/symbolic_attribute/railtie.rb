module SymbolicAttribute
  class Railtie < Rails::Railtie
    initializer 'symbolic_attribute.activerecord' do
      ActiveRecord::Base.send :include, SymbolicAttribute::Concern
    end
  end
end