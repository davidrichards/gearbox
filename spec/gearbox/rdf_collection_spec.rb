require_relative '../spec_helper'

include Gearbox

describe RDFCollection do
  
  subject { RDFCollection.new() }

  it "uses RDF::Enumerable " do
    RDFCollection.included_modules.must_include RDF::Enumerable
  end
  
  it "adds statements with add_statement or []=" do
    statement = RDF::Statement(:a, :b, :c)
    subject.add_statement :x, statement
    subject[:y] = statement
    
    subject[:x].must_equal statement
    subject[:y].must_equal statement
  end
  
  it "looks up statements by []" do
    statement = RDF::Statement(:a, :b, :c)
    subject[:x] = statement
    subject[:x].must_equal statement
  end
  
  it "normalizes keys to symbols" do
    # Note: end product is lowercase and underscored.
    # Removing white space, non-alphanumeric, repeats, 
    # leading and trailing underscores
    key = %[*  Something $trange !@#$\%^&]
    normalized_key = :something_trange
    statement = RDF::Statement(:a, :b, :c)
    subject[key] = statement
    subject[normalized_key].must_equal statement
  end
  
  it "uses a has_key? interface, by normalizing the key" do
    key = %[*  Something $trange !@#$\%^&]
    subject[key] = RDF::Statement(:a, :b, :c)
    subject.has_key?(key).must_equal true
  end
  
  it "uses has_key? without normalizing the key, when asked" do
    key = %[*  Something $trange !@#$\%^&]
    normalized_key = :something_trange
    subject[key] = RDF::Statement(:a, :b, :c)
    subject.has_key?(key, :normalize => false).must_equal false
    subject.has_key?(normalized_key, :normalize => false).must_equal true
  end
end
