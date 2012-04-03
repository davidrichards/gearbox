require_relative '../../spec_helper'

include Gearbox

describe SubjectMethods do
  
  before do
    @class = Class.new do
      include SubjectMethods
    end
  end
  
  subject { @class.new }
  
  it "uses a class-level configuration style"
  # configuration style (will move out later): x :y instead of x = :y
  # After I figure out how to do this, move it to another module, and take the tests out of here.
  
  it "uses id_method to define which method sets the id" do
    def subject.new_id; :new_id; end
    subject.id_method(:new_id)
    subject.id.must_equal :new_id
  end
  
  it "defaults id_method to :object_id" do
    subject.id_method.must_equal :object_id
  end
  
  it "can define the base_uri on the class level"
  it "can set the base_uri at initialization"
  it "can set the base_uri in an attribute style on the instance"
  it "uses subject_decorator_method as an optional method when setting the subject"
  it "defaults the subject to a string version of the id"
  it "uses the subject_decorator_method to override id in subject"
  it "uses base_uri and id or subject_decorator_method to set the subject"

end
