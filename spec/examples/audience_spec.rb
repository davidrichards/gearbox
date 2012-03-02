require_relative '../spec_helper'

include Gearbox

describe Audience do
  
  subject { Audience.new() }

  it "has a name getter and setter" do
    subject.name = "Dolphins"
    subject.name.must_equal("Dolphins")
  end
  
  it "has a resources association" do
    subject.resource_source = OpenStruct.public_method(:new)
    location = "http://example.com"
    resource = subject.add_resource(:location => location)
    subject.resources[0].must_equal resource
    resource.audience.must_equal subject
    resource.location.must_equal location
  end
  
  it "produces popular_themes"
  it "allows hash-based filters for popular_themes"
  it "produces explicit_participants"
  it "allows hash-based filters for explicit_participants"

end
