require_relative '../../spec_helper'

include Gearbox

describe Resource do
  
  before do
    @class = Class.new do
      def self.name; 'demo_class'; end
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

end
