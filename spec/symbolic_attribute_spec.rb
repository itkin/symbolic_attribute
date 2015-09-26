require 'spec_helper'
require 'active_model'

describe SymbolicAttribute do

  class SubjectClass
    attr_accessor :role
    include ActiveModel::Validations
    include SymbolicAttribute::Concern

    def read_attribute(attr)
      instance_variable_get :"@#{attr}"
    end
    symbolic_attribute :role, :values => [:buyer, :seller], :allow_nil => true
  end

  let(:subject_class) { SubjectClass }
  subject { subject_class.new }

  it 'has a version number' do
    expect(SymbolicAttribute::VERSION).not_to be nil
  end

  it 'reader symbolizes attribute' do
    subject.role = "fuu"
    expect(subject.role).to eq :fuu
  end

  it 'generates a dynamic class method listing choices' do
    expect(subject_class.roles).to eq [:buyer, :seller]
  end

  it 'validates inclusion ' do
    expect{
      subject.role = "fuu"
    }.to change{subject.valid?}.from(true).to(false)
  end
end
