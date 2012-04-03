require_relative '../../spec_helper'

include Gearbox

describe Resource do
  
  before do
    @class = Class.new do
      include Gearbox::Resource
    end
  end
  
  subject { @class.new }
  
  it "uses AdHocProperties" do
    @class.included_modules.must_include Gearbox::AdHocProperties
  end
  
  it "uses SemanticAccessors" do
    @class.included_modules.must_include Gearbox::SemanticAccessors
  end
  
  it "uses RDF::Mutable" do
    @class.included_modules.must_include RDF::Mutable
  end
  
  it "uses RDF::Queryable" do
    @class.included_modules.must_include RDF::Queryable
  end
  
  describe "Enumerable integration" do
    it "has each defined on the model" do
      subject.respond_to?(:each).must_equal true
    end
    
    it "produces RDF statements from the enumeration" do
      @class.attribute :name, :predicate => RDF::FOAF.name
      subject = @class.new(:name => "George")
      subject.to_a.must_equal([RDF::Statement.new(subject.subject, RDF::FOAF.name, RDF::Literal.new("George"))])
    end
  end

end
