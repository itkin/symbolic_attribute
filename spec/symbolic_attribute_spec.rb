require 'spec_helper'

describe SymbolicAttribute do

  class TargetClass
    attr_accessor :role
    def read_attribute(attr)
      instance_variable_get :"@#{attr}"
    end
    include SymbolicAttribute::Concern
    symbolic_attribute :role, :choices => [:buyer, :seller]
  end

  let(:target) { TargetClass.new }

  it 'has a version number' do
    expect(SymbolicAttribute::VERSION).not_to be nil
  end

  it 'reader symbolizes attribute' do
    target.role = "fuu"
    expect(target.role).to eq :fuu
  end

  it 'generates a dynamic class method listing choices' do
    expect(TargetClass.available_roles).to eq [:buyer, :seller]
  end

end
