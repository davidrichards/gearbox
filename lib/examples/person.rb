module Example
  class Person
    
    include Gearbox::Resource
    
    attribute :name, :predicate => RDF::FOAF.givenname
    attribute :twitter_account, :predicate => RDF::FOAF.accountName
    attribute :email, :predicate => RDF::FOAF.mbox
    attribute :website, :predicate => RDF::FOAF.weblog
    attribute :phone, :predicate => RDF::FOAF.phone
    
    attr_accessor :resource
    # association :resource, :class => Resource
    
  end
end


#     Person
#       name
#       tweet account | email | website | phone

# it "has a people association" do
#   subject.person_source = OpenStruct.public_method(:new)
#   name = "George Q. Cannon"
#   twitter_account = "gcannon"
#   person = subject.add_person(:name => name, :twitter_account => twitter_account)
#   subject.people[0].must_equal person
#   person.resource.must_equal subject
#   person.name.must_equal name
#   person.twitter_account.must_equal twitter_account
# end

