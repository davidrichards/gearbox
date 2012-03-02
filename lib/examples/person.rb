module Gearbox
  class Person
    
    attr_accessor :name
    attr_accessor :twitter_account
    attr_accessor :email
    attr_accessor :website
    attr_accessor :phone
    attr_accessor :resource
    
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

