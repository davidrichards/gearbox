require_relative '../../spec_helper'

include Gearbox

describe SemanticAccessors do
  
  
  describe "Class methods" do
    before do
      @class = Class.new do
        def self.name; 'demo_class'; end
        include SemanticAccessors
      end
    end

    it "uses an attributes hash" do
      @class.attributes.must_be_kind_of Hash
    end
    
    describe "attribute" do
      it "has an attribute method" do
        @class.respond_to?(:attribute).must_equal true
      end
      
      it "defines a setter and getter" do
        @class.attribute(:name, :predicate => RDF::FOAF.name)
        subject = @class.new
        subject.respond_to?(:name).must_equal true
        subject.respond_to?(:name=).must_equal true
      end
      
      it "stores the options + {:name => name} in the attributes hash" do
        @class.attribute(:name, :predicate => RDF::FOAF.name)
        @class.attributes[:name].must_equal({:name => :name, :predicate => RDF::FOAF.name})
      end
    end
  end # "Class methods"
  
  describe "Instance methods" do
    before do
      @class = Class.new do
        include SemanticAccessors
        attribute :name, :predicate => RDF::FOAF.name
      end
    end

    subject { @class.new }
    
    it "defaults the id to object_id" do
      subject.id.must_equal subject.object_id
    end
    
    it "has an id setter" do
      subject.id = :whale
      subject.id.must_equal :whale
    end
    
    it "creates a setter and a getter for each attribute" do
      subject.name = "George"
      subject.name.must_equal "George"
    end
    
    it "supports the attribute data types" do
      # In fact, it supports the full attribute system, this is just a quick check.
      @class.attribute :birthday, :predicate => RDF::FOAF.birthday, :datatype => RDF::XSD.date
      subject.birthday = Time.now
      subject.birthday.must_equal Time.now.to_date
    end
    
    it "creates an attributes hash from attribute values" do
      subject.name = "George"
      subject.attributes.must_equal({:id => subject.id, :name => "George"})
    end
    
    it "uses the default attribute parameter to set defaults" do
      @class.attribute :spanish_name, :predicate => RDF::FOAF.name, :language => :es, :default => "Jorge"
      subject = @class.new
      subject.spanish_name.must_equal "Jorge"
    end
    
    it "can take attribute values as an initialization hash" do
      subject = @class.new(:name => "George")
      subject.name.must_equal "George"
    end
    
    # TODO: Once I implement some finds via SPARQL, I should standardize the kind of data I'll be feeding
    # the model initialization.  At that point, either refactor the RDF::Statement feature in Attribute,
    # or add it in the initialization process.
  end # "Instance methods"
end
