require_relative '../spec_helper'

include Gearbox

describe Repository do
  
  subject { Repository.new }
  
  it "subclasses a SPARQL::Client::Repository" do
    Gearbox::Repository.ancestors.must_include ::SPARQL::Client::Repository
  end
  
  it "defaults the endpoint to http://localhost:8000" do
    subject.client.url.to_s.must_equal 'http://localhost:8000'
  end

  it "creates the data_uri as uri/data/" do
    uri = subject.client.url.to_s
    subject.data_uri.must_equal "#{uri}/data/"
  end
  
  it "creates the update_uri as uri/update/" do
    uri = subject.client.url.to_s
    subject.update_uri.must_equal "#{uri}/update/"
  end
  
  it "creates the status_uri as uri/status/" do
    uri = subject.client.url.to_s
    subject.status_uri.must_equal "#{uri}/status/"
  end
  
  it "creates the size_uri as uri/size/" do
    uri = subject.client.url.to_s
    subject.size_uri.must_equal "#{uri}/size/"
  end
  
  it "implements each" do
    subject.respond_to?(:each).must_equal true
  end
  
  it "implements insert_statement" do
    subject.respond_to?(:insert_statement).must_equal true
  end
  
  it "implements delete_statement" do
    subject.respond_to?(:delete_statement).must_equal true
  end
  
  it "uses a load_handler to abstract the load (testing and async would need a different load)" do
    subject.load_handler = lambda{:loaded}
    subject.load!.must_equal :loaded
  end
  
  # load, load_data, update, update_data, delete, insert... (possibly BGP can assemble these)
  # select, ask, describe, construct (possibly SPARQL client can do all of this)
  # has_statement?, dump_statement, has_triple? has_quad?
end
