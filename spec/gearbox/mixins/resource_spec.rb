require_relative '../../spec_helper'

include Gearbox

describe Resource do
  
  before do
    @class = Class.new do
      include Gearbox::Resource
    end
  end
  
  subject { @class.new }
  
  # Rethinking this one, they will be much more robust soon.
  # This is more for knowledge base discovery or throw-away models
  # So there's a new approach on the horizon of my imagination.
  # it "uses AdHocProperties" do
  #   @class.included_modules.must_include Gearbox::AdHocProperties
  # end
  
  it "uses SemanticAccessors" do
    @class.included_modules.must_include Gearbox::SemanticAccessors
  end
  
  it "uses SubjectMethods" do
    @class.included_modules.must_include Gearbox::SubjectMethods
  end
  
  it "uses ActiveModelImplementation" do
    @class.included_modules.must_include Gearbox::ActiveModelImplementation
  end
  
  it "uses RDF::Mutable" do
    @class.included_modules.must_include RDF::Mutable
  end
  
  describe "Load order" do
    # Unfortunately, the load order is important here.
    # There is only one example right now: id.
    # id is part of the subject system. It's actually quite robust, so that any identification pattern
    # can be implemented in Gearbox.  That's handled in the SubjectMethods.  The attribute system needs
    # id for some ActiveModel goodness.  So, I have to load SubjectMethods before SemanticAccessors.
    # A recent MWRC kept picking on this dependency problem, but none of their suggestions would help
    # make this code follow the Law of Demeter any better.
    
    it "has an id for the attribute system" do
      @class.attribute :name, :predicate => RDF::FOAF.name
      subject = @class.new(:name => "George")
      subject.attributes.must_equal({:id => subject.id, :name => "George"})
    end
  end

end
