require_relative '../../spec_helper'

include Gearbox

describe SemanticAccessors do
  
  before do
    @class = Class.new do
      def self.name; 'demo_class'; end
      include SemanticAccessors
    end
  end
  
  subject { @class.new }
  
  it "has an rdf_collection" do
    subject.must_respond_to :rdf_collection
    subject.rdf_collection.must_be_kind_of RDFCollection
  end
  
  it "has an attribute_collection on the class" do
    subject.class.must_respond_to :attribute_collection
    subject.class.attribute_collection.must_be_kind_of AttributeCollection
  end
  
  it "has an attribute macro for setting up new attributes" do
    @class.attribute :given_name, :predicate => RDF::FOAF.givenname
    subject.given_name = "Frank"
    subject.given_name.must_equal("Frank")
  end
  
  it "raises an error unless a predicate is defined" do
    lambda{@class.attribute :given_name}.must_raise(ArgumentError, /predicate/i)
  end
  
  it "takes a hash on initialization" do
    @class.attribute :given_name, :predicate => RDF::FOAF.givenname
    subject = @class.new :given_name => "Frank"
    subject.given_name.must_equal "Frank"
  end
  
  it "takes an RDFCollection on initialization" do
    @class.attribute :given_name, :predicate => RDF::FOAF.givenname
    collection = RDFCollection.new
    collection[:given_name] = RDF::Statement.new(:a, RDF::FOAF.givenname, 'Frank')
    collection[:family_name] = RDF::Statement.new(:a, RDF::FOAF.familyname, 'Wilde')
    subject = @class.new(collection)
    subject.given_name.must_equal "Frank"
  end
  
  it "takes an Array of RDF::Statement objects on initialization"

end
