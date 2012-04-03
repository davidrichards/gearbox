=begin
  Useful for working with SPARQL, making sure this works...
=end

require_relative 'lib/gearbox'

def r
  @r ||= RDF::Repository.new do |graph|
    graph << [RDF::Node.new, RDF::FOAF.givenname, "Frank"]
  end
end

def e(string)
  SPARQL.execute(string, r)
end

include Example