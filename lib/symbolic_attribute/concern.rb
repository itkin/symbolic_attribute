require 'active_support/concern'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute'

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

        # Add a class method and validation if choices option is defined
        if opts.symbolize_keys!.key?(:choices)
          class_attr_name = attr.to_s.pluralize
          class_attribute class_attr_name, :instance_reader => false, :instance_writer => false
          send "#{class_attr_name}=", opts.delete(:choices).map(&:to_sym)
          validates attr, opts.merge(:inclusion => { :in => proc{|instance| instance.class.send(class_attr_name)} })
        end

      end
    end
  end
end

