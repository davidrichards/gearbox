require_relative 'spec_helper'

describe Gearbox do
  
  it "depends on OpenStruct" do
    defined?(OpenStruct).must_equal('constant')
  end
  
  it "depends on sparql" do
    defined?(SPARQL).must_equal('constant')
  end
  
  it "depends on ActiveModel" do
    defined?(ActiveModel).must_equal('constant')
  end
end

