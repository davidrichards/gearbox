# Useful for a Pry session.

require 'forwardable'
require 'fileutils'
require 'yaml'

require 'restclient'
# The dependency on Nokogiri may go away, I'll be experimenting 
# with content types before I commit to adding this permentantly
require 'nokogiri'

include Gearbox

# These are temporary classes for helping me get better introspection 
# on what should be available in Gearbox 1.0.  There are hard dependencies
# here on having a local SPARQL end point that follows the 4Store conventions
# and running on port 8000.
class SPARQLResult
  
  # Get a result table from the query
  def self.get_result(result_string)
    result = new(result_string)
    result.result_table
  end
  
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
    
    # Extracts one or more values from the Result Table
    def values.extract(*targets)
      array = self.dup
      keys = array.shift
      indices = targets.map {|key| keys.index(key.to_s)}
      array.map {|e| e[*indices]}
    end
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

class SPARQLEndpoint
  
  attr_reader :base_uri, :session
  
  def initialize(opts={})
    @base_uri = opts.fetch(:uri, "http://localhost:8000")
    @session = opts[:session]
  end
  
  def load_queries
    return nil unless stored_queries_filename
    query_hash = YAML.load_file(stored_queries_filename)
    return nil unless query_hash.is_a?(Hash)
    query_hash.each do |name, sparql|
      register_query(name, sparql)
    end
  end
  
  def save_queries
    return nil unless stored_queries_filename
    File.open(stored_queries_filename, 'w') {|f| f.puts YAML.dump(registered)}
    true
  end
  
  def stored_queries_filename
    return @stored_queries if @stored_queries
    return nil unless session
    return nil unless user_directory = session.user_directory
    @stored_queries = File.join(user_directory, 'stored_queries.yml')
  end
  private :stored_queries_filename
  
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
    SPARQLResult.get_result(response)
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
    
    self.class.send(:define_method, "#{name}!") do
      memoized[name] = query(registered[name])
    end
    
    true
  end
  alias :register :register_query

  # Lookup some SPARQL
  def query_for(name)
    registered[name]
  end
  alias :sparql_for :query_for
  
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

class Utilities
  # Great for writing ad hoc models.
  # TODO: Make this work for several sessions. (Thread it?)
  def write_model(name)
    raise "Directory does not exist" unless File.exist?(model_directory)
    filename = File.join(model_directory, "#{name}.rb")
    raise "ENV['EDITOR'] not set" unless ENV['EDITOR']
    `#{ENV['EDITOR']} #{filename}`
    load filename
  end
  alias :update_model :write_model
  alias :build_model :write_model
  alias :create_model :write_model
  
  def edit_models
    raise "Directory does not exist" unless File.exist?(model_directory)
    raise "ENV['EDITOR'] not set" unless ENV['EDITOR']
    `#{ENV['EDITOR']} #{model_directory}`
    puts "The models are open in your editor, but you will need to load them again after completing your work."
    true
  end
  
  def load_model(name)
    raise "Directory does not exist" unless File.exist?(model_directory)
    filename = File.join(model_directory, "#{name}.rb")
    load filename
  end
  
  def load_models
    Dir.glob("#{model_directory}/*.rb").map { |filename| load filename}
  end

  def user_directory
    File.expand_path("~/.gearbox")
  end
  
  def user_model_directory
    @user_model_directory ||= File.join(user_directory, "models")
  end
  
  def model_directory
    return @model_directory if @model_directory
    if File.exists?(user_directory)
      FileUtils.mkdir(user_model_directory) unless File.exists?(user_model_directory)
      @model_directory = user_model_directory
    elsif File.exists?("/tmp")
      @model_directory = File.expand_path("/tmp") if File.exists?("/tmp")
    end
    @model_directory
  end
  attr_writer :model_directory
  
  def list_models
    Dir.glob("#{model_directory}/*.rb").map { |file| File.basename(file).split('.')[0..-2].join('.').to_sym}
  end
  
  def tmp_directory
    @tmp_directory ||= "/tmp"
  end
  attr_writer :tmp_directory
  
  def endpoint(opts={})
    @endpoint = nil if opts[:reload]
    @endpoint ||= SPARQLEndpoint.new({:session => self}.merge(opts)).tap {|e| e.load_queries}
  end
  
  require 'fileutils'
  # Great for writing descriptions without messing around with quotes and escapes and things
  # TODO: Make this work for several sessions. (Thread it?)
  def get_note(opts={})
    type = opts.fetch(:type, 'md')
    contents = opts[:contents]
    contents = opts[:content] if opts.has_key?(:content) and not contents
    begin
      filename = File.join(tmp_directory, "#{self.object_id}.#{type}")
      i = 0
      while File.exist?(filename)
        filename = File.join(tmp_directory, "#{self.object_id}#{i}.#{type}")
        i += 1
      end
      raise "ENV['EDITOR'] not set" unless ENV['EDITOR']
      File.open(filename, "w") {|f| f.print contents}
      `#{ENV['EDITOR']} #{filename}`
      contents = File.read(filename)
    ensure
      puts "Cleaning up temp file and exiting ..."
      FileUtils.rm_f(filename)
    end
  end
  
end

@utilities = Utilities.new
extend Forwardable
def_delegators :@utilities, 
  :build_model, 
  :edit_models,
  :endpoint,
  :get_note,
  :list_models,
  :load_model,
  :load_models,
  :model_directory, 
  :model_directory=, 
  :tmp_directory,
  :tmp_directory=,
  :update_model,
  :write_model
  