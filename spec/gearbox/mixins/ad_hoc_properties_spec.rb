require_relative '../../spec_helper'

include Gearbox

describe AdHocProperties do
  
  # before do
  #   @class = Class.new do
  #     def self.name; 'demo_class'; end
  #     include SemanticAccessors
  #     include AdHocProperties
  #   end
  # end
  # 
  # subject { @class.new }
  # 
  # it "has an id getter and setter" do
  #   id = 1
  #   subject.id = id
  #   subject.id.must_equal(id)
  # end
  # 
  # # Concerned about the id and the model lifecycle.
  # it "offers a bnode, deriving from the id" do
  #   subject.id = 3
  #   subject.bnode.must_be_kind_of RDF::Node
  #   subject.bnode.id.must_equal "demo_class_3"
  # end
  # 
  # it "generates a UUID for the bnode if the id is nil" do
  #   subject.id.must_be_nil
  #   subject.bnode
  #   subject.id.wont_be_nil
  #   subject.bnode.id.must_equal "demo_class_#{subject.id}"
  # end
  # 
  # it "has an attributes_list" do
  #   subject.must_respond_to :attributes_list
  #   subject.attributes_list.must_be_kind_of RDFCollection
  # end
  # 
  # # Excited about models that can take new properties ad hoc, therefore being more 
  # # friendly to the underlying graph and the nature of semantic data generally.
  # it "can add_property with a predicate and an object" do
  #   subject.add_property :field_name, :predicate, :object
  #   newly_created = subject.attributes_list[:field_name]
  #   newly_created.subject.id.must_equal subject.bnode.id
  #   newly_created.predicate.id.must_equal 'predicate'
  #   newly_created.object.id.must_equal 'object'
  # end

end
