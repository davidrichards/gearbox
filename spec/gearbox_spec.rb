require_relative 'spec_helper'

describe Gearbox do
  
  it "depends on OpenStruct" do
    defined?(OpenStruct).must_equal('constant')
  end
  
  it "depends on uuid" do
    defined?(UUID).must_equal('constant')
  end
  
  it "depends on sparql" do
    defined?(SPARQL).must_equal('constant')
  end
end

