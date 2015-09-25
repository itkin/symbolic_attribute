require 'active_support/concern'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module SymbolicAttribute
  module Concern
    extend ActiveSupport::Concern
    module ClassMethods
      def symbolic_attribute(attr, opts = {})

        # Getter method
        define_method attr do
          val = read_attribute(attr)
          val.to_sym unless val.blank?
        end

        if opts.symbolize_keys!.key?(:choices)
          metaclass = class << self; self; end
          metaclass.instance_eval do
            define_method :"available_#{attr.to_s.pluralize}" do
              opts[:choices]
            end
          end
        end

      end
    end
  end
end

