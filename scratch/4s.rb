require 'linkeddata'
require 'rest_client'
require 'nokogiri'
require 'pry'

# endpoint = "http://localhost:8000/data/"
# stmt = <<-END
# INSERT DATA 
# {
#   <http://example.org/subject> <http://example.org/predicate> <http://example.org/object> 
# }
# END
# response = RestClient.put endpoint, stmt, :content_type => "application/rdf+xml"
# graph    = 'http://source.data.gov.uk/data/reference/organogram-co/2010-06-30'
# binding.pry
# response = RestClient.put endpoint + graph, stmt, :content_type => "application/rdf+xml"

def load_graph
  
  endpoint = "http://localhost:8000/data/"
  filename = File.expand_path("../index.rdf", __FILE__)
  graph    = 'http://source.data.gov.uk/data/reference/organogram-co/2010-06-30'
  response = RestClient.put endpoint + graph, File.read(filename), :content_type => "application/rdf+xml"
  # response = RestClient.put endpoint, File.read(filename), :content_type => "application/rdf+xml"
  puts "Response: #{response.code}", response.to_str
end

def count_triples
  endpoint = "http://localhost:8000/sparql/"
  # sparql = "SELECT (COUNT(DISTINCT ?s) AS ?count) WHERE { ?s ?p ?o } LIMIT 10"
  sparql = "SELECT * WHERE { ?s ?p ?o } LIMIT 10"
  response = RestClient.post endpoint, :query => sparql
  xml = Nokogiri::XML(response.to_str)
end

def ordered_variables
  endpoint = "http://localhost:8000/sparql/"
  sparql = "SELECT (COUNT(DISTINCT ?s) AS ?count) WHERE { ?s ?p ?o } LIMIT 10"
  # sparql = "SELECT * WHERE { ?s ?p ?o } LIMIT 10"
  response = RestClient.post endpoint, :query => sparql
  xml = Nokogiri::XML(response.to_str)
  found = xml.xpath("//sparql:head/sparql:variable/@name", "sparql" => "http://www.w3.org/2005/sparql-results#").map(&:value)
  found
  # xml.xpath("//sparql:head/sparql:variable", "sparql" => "http://www.w3.org/2005/sparql-results#").map {|e| e.attr('name')}
end

# result = ordered_variables


# Examples of SPARQL Update 1.1 for 4Store:
# http://4store.org/trac/wiki/SparqlServer

# endpoint = "http://localhost:8000/sparql/"
# You can use  sparql-query to query the SPARQL server on the command line.


# Soft limit of about 1000, what is that?  triples?  seconds?  

class NotImplemented < StandardError; end

# Geared towards interpreting whatever results we get back from a SPARQL result
class SPARQLResult
  
  SPARQL_NAMESPACE = {'sparql' => 'http://www.w3.org/2005/sparql-results#'} unless defined?(SPARQL_NAMESPACE)
  attr_reader :result_string
  
  def initialize(result_string)
    @result_string = result_string
  end
  
  def ask?
    not xml.xpath('//sparql:boolean', SPARQL_NAMESPACE).empty?
  end
  
  def ask_value
    return nil unless ask?
    xml.xpath('//sparql:boolean', SPARQL_NAMESPACE).text == 'true'
  end
  
  def results
    return ask_value if ask?
    @results = Hash.new {|h, k| h[k] = []}
    xml.xpath('//sparql:result', SPARQL_NAMESPACE).each do |result|
      result.xpath('./sparql:binding', SPARQL_NAMESPACE).each do |variable_binding|
        name = variable_binding.attr('name')
        value = extract_value(variable_binding)
        @results[name] << value
      end
    end
    @results
  end
  
  def result_table
    return ask_value if ask?
    keys = head_node.xpath(".//sparql:variable/@name", SPARQL_NAMESPACE).map(&:value)
    values = []
    xml.xpath('//sparql:result', SPARQL_NAMESPACE).each do |result|
      record = []
      result.xpath('./sparql:binding', SPARQL_NAMESPACE).each do |variable_binding|
        value = extract_value(variable_binding)
        record << value
      end
      values << record
    end
    # puts keys.inspect
    # values.each {|v| puts v.inspect}
    values.unshift keys
    values
  end
  
  def inspect
    # "SPARQLResult: #{result_string[0..50].split(/\n/)[0]}"
    "SPARQLResult: #{results.keys}"
  end
  
  private
  
    def extract_value(variable_binding_node)
      # Not Implemented: literals, sequences, indices, data types, languages
      # Need to deal with bnode, uri, or literal.  Ignoring all of that for now...
      variable_binding_node.text
    end
    
    def head_node
      @head_node ||= xml.xpath('//sparql:head', SPARQL_NAMESPACE)
    end
    
    def variable_nodes
      @variable_nodes ||= head_node.xpath('//sparql::variable', SPARQL_NAMESPACE)
    end
    
    def xml
      @xml ||= Nokogiri::XML(result_string)
    end
end


# response = RestClient.put endpoint + graph, File.read(filename), :content_type => "application/rdf+xml"

def exercise_sparql_result
  endpoint = "http://localhost:8000/sparql/"
  sparql = "SELECT * WHERE { ?s ?p ?o } LIMIT 10"
  # sparql = "ASK { ?s ?p ?o }"
  response = RestClient.post endpoint, :query => sparql
  s = SPARQLResult.new(response)
  s.results
end

# puts exercise_sparql_result.inspect

# TODO: Not dealing with the soft limit yet

# Need to figure out how to write a finder for a model...
# 1) load the data in the graph
# 2) write the query
# 3) start to figure out the different ways to construct this...
def constructing_model_sparql
end

class SPARQLEndpoint
  
  attr_reader :base_uri
  
  def initialize(uri="http://localhost:8000")
    @base_uri = uri
  end
  
  attr_writer :select_uri
  def select_uri
    @select_uri ||= File.join(base_uri, 'sparql/')
  end
  
  attr_writer :update_uri
  def update_uri
    @update_uri ||= File.join(base_uri, 'data/')
  end
  
  def query(sparql)
    response = RestClient.post select_uri, :query => sparql
    SPARQLResult.new(response)
  end
  
  def queries
    registered.keys
  end
  
  def memoize_query(name, sparql=nil)
    return memoized[name] if memoized[name]
    register_query(name, sparql)
    memoized[name] ||= query(sparql)
  end
  alias :memoize :memoize_query
  
  def register_query(name, sparql)
    registered[name] = sparql
    memoized[name] = nil
    self.class.send(:define_method, name) do
      memoized[name] ||= query(registered[name])
    end
    true
  end
  alias :register :register_query

  def registered
    @registered ||= {}
  end
  
  def memoized
    @memoized ||= {}
  end

  def inspect
    "SPARQLEndpoint: #{base_uri}"
  end
  
end

# s = SPARQLEndpoint.new
# s.register('basic', "SELECT * WHERE { ?s ?p ?o } LIMIT 10")
# s.register 'predicates', 'select distinct ?predicate where {?s ?predicate ?o}'
# s.register 'notations', 'select distinct ?subject ?notations where {?subject <http://www.w3.org/2004/02/skos/core#notation}'
# s.register 'phones', 'select distinct ?phone where {?s <http://xmlns.com/foaf/0.1/phone> ?phone}'
# binding.pry

require 'fileutils'
# Note, I haven't come up with a good fallback if ENV['EDITOR'] hasn't been defined yet.
# I tried to open vim as a fallback, I ended up in non-terminal mode, had to kill processes manually.
# Will need to fork or something: http://workingwithunixprocesses.com/
def get_note(type="md")
  contents = nil
  begin
    filename = "/tmp/#{self.object_id}.#{type}"
    while File.exist?(filename)
      i ||= 0
      filename = "/tmp/#{self.object_id}#{i}.#{type}"
    end
    `#{ENV['EDITOR']} #{filename}`
    contents = File.read(filename)
  ensure
    puts "Exiting ..."
    FileUtils.rm_f(filename)
  end
  # contents
end

def get_model_contents(subject='http://reference.data.gov.uk/id/department/co/post/44')
  s = SPARQLEndpoint.new
  s.register 'model', <<-END
    SELECT DISTINCT ?predicate ?value
    WHERE {
      {<#{subject}> ?predicate ?value}
      UNION
      {?value ?predicate <#{subject}>}
    }
  END
  s.model
end

# get_model_contents

def write_model(name)
  filename = "/tmp/#{name}.rb"
  `#{ENV['EDITOR']} #{filename}`
  load filename
end
alias :update_model :write_model

=begin

  The task list says to play with more semantic models: exploratory SPARQL, SPARQL for a single model, discover data structures in other LOD.  Basically, I'm trying to figure out how to be familiar with this stuff.  
=end

require 'forwardable'

class Person

  extend Forwardable
  def_delegators :@endpoint, :white_list, :direct_attributes
  
  attr_reader :endpoint, :id
  
  def initialize(id="person178")
    @id = id
    @endpoint = SPARQLEndpoint.new
    @endpoint.register :white_list, white_list_sparql
    @endpoint.register :direct_attributes, direct_attributes_sparql
  end
  
  def inspect
    "Person: #{URI.split(subject)[-1]}"
  end
  
  def predicate_hash
    @predicate_hash ||= {
      "?email" => "http://xmlns.com/foaf/0.1/mbox",
      "?page" => "http://xmlns.com/foaf/0.1/page",
      "?phone" => "http://xmlns.com/foaf/0.1/phone",
      "?name" => "http://xmlns.com/foaf/0.1/name"
    }
  end
  
  def base_uri
    "http://source.data.gov.uk/data/reference/organogram-co/2010-10-31#"
  end
  
  def subject
    "#{base_uri}#{id}"
  end
  
  def white_list_sparql
    <<-END
      SELECT *
      #{white_list_where_clause}
    END
  end
  
  def white_list_where_clause
    @white_list_where_clause ||= <<-END
      WHERE {
        #{predicate_hash.map {|variable, predicate| "<#{subject}> <#{predicate}> #{variable}"}.join(" .\n")}
      }
    END
  end
  
  def direct_attributes_sparql
    @direct_attributes_sparql ||=<<-END
      SELECT DISTINCT ?predicate ?value
      WHERE {
        {<#{subject}> ?predicate ?value}
        UNION
        {?value ?predicate <#{subject}>}
      }
    END
  end
end
