require 'active_support/concern'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute'

module SymbolicAttribute
  module Concern
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations unless included_modules.include?(ActiveModel::Validations)
    end

    module ClassMethods
      def symbolic_attribute(attr, opts = {})

        # Getter method
        define_method attr do
          val = read_attribute(attr)
          val.to_sym unless val.blank?
        end

        # Add a class method and validation if :values option key is defined
        if opts.symbolize_keys!.key?(:values)
          class_attr_name = attr.to_s.pluralize
          class_attribute class_attr_name, :instance_reader => false, :instance_writer => false
          send "#{class_attr_name}=", opts.delete(:values).map(&:to_sym)
          validates attr, opts.merge(:inclusion => { :in => proc{|instance| instance.class.send(class_attr_name)} })

          define_singleton_method "human_#{attr}" do |val, options={}|
            options   = { :count => 1 }.merge!(options)

            defaults = lookup_ancestors.map do |klass|
              :"#{self.i18n_scope}.symbolic_attributes.#{klass.model_name.i18n_key}.#{attr}.#{val}"
            end

            defaults << options.delete(:default) if options[:default]
            defaults << val.to_s.humanize

            options[:default] = defaults
            I18n.translate(defaults.shift, options)
          end

          define_method  "human_#{attr}" do |options = {}|
            self.class.send "human_#{attr}", send(attr), options
          end

        end

      end
    end
  end
end

