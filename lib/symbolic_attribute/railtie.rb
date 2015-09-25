module SymbolicAttribute
  class Railtie < Rails::Railtie
    initializer 'symbolic_attribute.active_record' do
      ActiveRecord::Base.send :include, Concern
    end
  end
end