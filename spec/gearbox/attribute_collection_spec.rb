require_relative '../spec_helper'

include Gearbox

describe AttributeCollection do
  
  subject { AttributeCollection.new }
  
  it "should add an attribute with a Hash and store an OpenStruct" do
    subject[:key] = {:this => :works}
    subject[:key].this.must_equal(:works)
  end
  
  it "normalizes keys to symbols" do
    # Note: end product is lowercase and underscored.
    # Removing white space, non-alphanumeric, repeats, 
    # leading and trailing underscores
    key = %[*  Something $trange !@#$\%^&]
    normalized_key = :something_trange
    value = {:this => :works}
    subject[key] = value
    subject[normalized_key].this.must_equal :works
    subject[key].this.must_equal :works
  end
  
  it "initializes with a default hash" do
    subject = AttributeCollection.new :this => :works
    subject[:key] = {:another => :value}
    subject[:key].another.must_equal :value
    subject[:key].this.must_equal :works
  end
  
end
