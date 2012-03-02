require_relative '../spec_helper'

include Gearbox

describe Person do
  
  subject { Person.new() }

  it "has a name getter and setter" do
    name = "George Q. Cannon"
    subject.name = name
    subject.name.must_equal(name)
  end
  
  it "has a twitter_account getter and setter" do
    twitter_account = "gcannon"
    subject.twitter_account = twitter_account
    subject.twitter_account.must_equal(twitter_account)
  end
  
  it "has a email getter and setter" do
    email = "george@example.com"
    subject.email = email
    subject.email.must_equal(email)
  end
  
  it "has a website getter and setter" do
    website = "example.com"
    subject.website = website
    subject.website.must_equal(website)
  end
  
  it "has a phone getter and setter" do
    phone = "801 555-1122"
    subject.phone = phone
    subject.phone.must_equal(phone)
  end
  
  it "has a resource getter and setter" do
    resource = "Some Resource"
    subject.resource = resource
    subject.resource.must_equal(resource)
  end

end
