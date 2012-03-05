require_relative '../spec_helper'

include Gearbox

describe RDFCollection do
  
  subject { RDFCollection.new() }

  it "uses RDF::Queryable " do
    RDFCollection.included_modules.must_include RDF::Queryable
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
  
  it "has a local_repository" do
    subject.local_repository.must_be_kind_of RDF::Repository
  end
  
  it "has a local_repository setter" do
    subject.local_repository = :blah
    subject.local_repository.must_equal :blah
  end
  
  it "delegates to the local_repository from each" do
    subject.local_repository = [1,2,3]
    subject.to_a.must_equal [1,2,3]
  end
  
  it "uses each_with_field_names to iterate the labeled statements" do
    statement = RDF::Statement(:a, :b, :c)
    subject.add_statement :x, statement
    subject.each_with_field_names.to_a.must_equal [[:x, statement]]
  end
  
  it "has a query method for SPARQL.execute" do
    statement = RDF::Statement(RDF::Node.new, RDF::FOAF.givenname, "Frank")
    subject.add_statement :x, statement
    subject.query("select ?object where {?s ?p ?object}")[0].object.value.must_equal "Frank"
  end
end
