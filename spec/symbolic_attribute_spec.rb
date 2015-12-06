require 'spec_helper'
require 'active_model'

describe SymbolicAttribute do

  class SubjectClass
    include SymbolicAttribute::Concern

    [:role, :right].each do |attr|
      attr_accessor attr
    end

    def read_attribute(attr)
      instance_variable_get :"@#{attr}"
    end

    symbolic_attribute :role, :values => [:buyer, :seller], :allow_nil => true
    symbolic_attribute :right, :plural=> :rightss, :values => [:user, :admin], :allow_nil => true
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

  it "subject class has human name name getter" do
    expect(I18n).to receive(:translate).with(:"activemodel.symbolic_attributes.subject_class.roles.buyer", :count=>1, :default=>["Buyer"])
    subject_class.human_role :buyer
  end

  it "subject has human name name getter" do
    subject.role = :seller
    expect(subject.human_role ).to eq "Seller"
  end

  it "accepts plural attribute name as passed as param" do
    expect(subject_class.rightss).to eq [:user, :admin]
  end

end
