require_relative '../spec_helper'

include Example

describe Reference do
  
  subject { Reference.new() }

  it "has a location getter and setter" do
    location = "http://example.com"
    subject.location = location
    subject.location.must_equal(location)
  end
  
  it "has an audience getter and setter" do
    audience = :audience
    subject.audience = audience
    subject.audience.must_equal audience
  end
  
  it "has a people association" do
    subject.person_source = OpenStruct.public_method(:new)
    name = "George Q. Cannon"
    twitter_account = "gcannon"
    person = subject.add_person(:name => name, :twitter_account => twitter_account)
    subject.people[0].must_equal person
    person.reference.must_equal subject
    person.name.must_equal name
    person.twitter_account.must_equal twitter_account
  end
  
  it "has a themes association" do
    subject.theme_source = OpenStruct.public_method(:new)
    name = "George Q. Cannon"
    tally = 3
    theme = subject.add_theme(:name => name, :tally => tally)
    subject.themes[0].must_equal theme
    theme.reference.must_equal subject
    theme.name.must_equal name
    theme.tally.must_equal tally
  end

end
