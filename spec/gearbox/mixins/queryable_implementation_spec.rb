require_relative '../../spec_helper'

include Gearbox

describe QueryableImplementation do
  
  before do
    @class = Class.new do
      include Gearbox::Resource
    end
  end
  
  subject { @class.new }

  it "uses RDF::Queryable" do
    @class = Class.new {include Gearbox::QueryableImplementation}
    @class.included_modules.must_include RDF::Queryable
  end

  it "has each defined on the model" do
    subject.respond_to?(:each).must_equal true
  end
  
  it "produces RDF statements from the enumeration" do
    @class.attribute :name, :predicate => RDF::FOAF.name
    subject = @class.new(:name => "George")
    subject.to_a.must_equal([RDF::Statement.new(subject.subject, RDF::FOAF.name, RDF::Literal.new("George"))])
  end
  
  it "aliases each_statement to each" do
    @class.attribute :name, :predicate => RDF::FOAF.name
    subject = @class.new(:name => "George")
    subject.each_statement.to_a.must_equal([RDF::Statement.new(subject.subject, RDF::FOAF.name, RDF::Literal.new("George"))])
  end

end