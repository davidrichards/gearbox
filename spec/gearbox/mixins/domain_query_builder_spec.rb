require_relative '../../spec_helper'

include Gearbox

describe DomainQueryBuilder do
  
  before do
    @class = Class.new do
      include DomainQueryBuilder
    end
    
    @omni_model = Class.new do
      include Resource
      
      attribute :name, :predicate => RDF::FOAF.name
      
    end
  end

  # let(:base_uri) { "http://example.com" }
  let(:omni) { @omni_model.new }
  subject { @class.new }
  
  it "just works" do
    omni
  end
  
end

=begin

  This is the good stuff.  At this point, I start reading and writing data from the repository.  
  I have been relying on 4Store locally to offer an endpoint.  The concept is that this is standard-
  enough to be a good pattern for other SPARQL-endpoint-aware repositories.  This is a departure from
  a lot of the RDF.rb libraries, where they are storing triples in various data stores (mongo, postgres,
  sqlite, redis, cassandra, couchdb, and probably others) and using query patterns to extract these
  triples.  Here, we are allowing the SPARQL end points to understand their own architecture and deliverying
  our data as we need it.  This is partly due to having a near-standardized SPARQL Update 1.1 which defines
  how the basic CRUD can be accomplished in these endpoints.  That, and I need the SPIN to maintain the graph,
  rather than just assume the model got it right the first time.  That, and SPARQL is more expressive than the 
  query patterns as currently constituted in the RDF.rb world.  That, and I want a knowledge base that is 
  implementation agnostic once the data is stored in it.  I should be able to write an application in any 
  language I'd like and only have to rely on SPARQL to get the data in and out of the repository.
  
  OK, that needed to be said.  There is quite a bit of big-picture assumptions that I've been gleaning from
  the source codes.
  
  Meanwhile, we have a task before us today: start getting data in and out of a repository.  Tasks:
  
  * Read the query pattern codes, to make sure I'm not full of shit
  * Figure out how to mock this environment, I don't want tests to rely on a repository running.
  * Figure out the raw SPARQL for a single-model query
  * SPARQL for all instances of a model
  * SPARQL for a filtered list of instances
  * " + ordered
  * SPARQL to insert a model
  * SPARQL to insert a set of models
  * SPARQL to update a model
  * SPARQL to update a set of models
  * SPARQL to delete a model
  * SPARQL to delete a set of models
  
  At this point, it would probably be good to build a knowledge base regarding everything related to 
  database design, transactions, principles of data integrity, and similar concepts.  There will be more 
  features once I understand some of these design principles better.  Plus, building knowledge bases will
  tease out some of these same concerns empirically.  
  
  RDF::Query
  ==========
  
  * limited to select, ask, construct and describe
  * I didn't see support for union, and there may be other gaps
  * used to create SPARQL with a syntax like query.select.where(:variable => value).order([:v1, :v2])
  * would have to be extended to be complete, even for today's work
  * probably an unnecessary nicety in the short-run, maybe generally
  
  
  
=end
