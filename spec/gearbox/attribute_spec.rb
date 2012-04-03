require_relative '../spec_helper'

include Gearbox

describe Attribute do
  
  subject { Attribute.new }

  it "has an accessor for predicate" do
    subject.predicate = :predicate
    subject.predicate.must_equal :predicate
  end
  
  it "can load with :predicate or 'predicate'" do
    subject = Attribute.new(:predicate => :predicate)
    subject.predicate.must_equal :predicate
    subject = Attribute.new('predicate' => :predicate)
    subject.predicate.must_equal :predicate
  end
  
  it "has an accessor for reverse" do
    subject.reverse = :reverse
    subject.reverse.must_equal :reverse
  end
  
  it "can load with :reverse or 'reverse'" do
    subject = Attribute.new(:reverse => :reverse)
    subject.reverse.must_equal :reverse
    subject = Attribute.new('reverse' => :reverse)
    subject.reverse.must_equal :reverse
  end
  
  it "defaults reverse to false" do
    subject.reverse.must_equal false
  end
  
  it "has an accessor for index" do
    subject.index = :index
    subject.index.must_equal :index
  end
  
  it "can load with :index or 'index'" do
    subject = Attribute.new(:index => :index)
    subject.index.must_equal :index
    subject = Attribute.new('index' => :index)
    subject.index.must_equal :index
  end

  it "defaults index to false" do
    subject.index.must_equal false
  end
  
  it "has an accessor for name" do
    subject.name = :name
    subject.name.must_equal :name
  end
  
  it "can load with :name or 'name'" do
    subject = Attribute.new(:name => :name)
    subject.name.must_equal :name
    subject = Attribute.new('name' => :name)
    subject.name.must_equal :name
  end

  it "has an accessor for repository" do
    subject.repository = :repository
    subject.repository.must_equal :repository
  end
  
  it "can load with :repository or 'repository'" do
    subject = Attribute.new(:repository => :repository)
    subject.repository.must_equal :repository
    subject = Attribute.new('repository' => :repository)
    subject.repository.must_equal :repository
  end
  
  it "has an accessor for subject_decorator" do
    subject.subject_decorator = :some_method
    subject.subject_decorator.must_equal :some_method
  end

  it "can load with :subject_decorator or 'subject_decorator'" do
    subject = Attribute.new(:subject_decorator => :subject_decorator)
    subject.subject_decorator.must_equal :subject_decorator
    subject = Attribute.new('subject_decorator' => :subject_decorator)
    subject.subject_decorator.must_equal :subject_decorator
  end

  it "can attempt to build a subject, if the subject_decorator is set" do
    def subject.some_method; "special_subject"; end
    subject.subject_decorator = :some_method
    subject.subject.must_equal "special_subject"
  end
  
  it "returns nil from subject if the subject_decorator is not set" do
    subject.subject.must_equal nil
  end
  
  it "can load with :value or 'value'" do
    subject = Attribute.new(:value => :value)
    subject.to_value.must_equal :value
    subject = Attribute.new('value' => :value)
    subject.to_value.must_equal :value
  end
  
  it "uses to_value or get to lookup the value" do
    subject = Attribute.new(:value => :value)
    subject.to_value.must_equal :value
    subject.get.must_equal :value
  end
  
  it "has an accessor for datatype" do
    subject.datatype = :value
    subject.datatype.must_equal :value
  end

  it "can load with :datatype or 'datatype'" do
    subject = Attribute.new(:datatype => :datatype)
    subject.datatype.must_equal :datatype
    subject = Attribute.new('datatype' => :datatype)
    subject.datatype.must_equal :datatype
  end

  it "has an accessor for language" do
    subject.datatype = :language
    subject.datatype.must_equal :language
  end

  it "can load with :language or 'language'" do
    subject = Attribute.new(:language => :language)
    subject.language.must_equal :language
    subject = Attribute.new('language' => :language)
    subject.language.must_equal :language
  end
  
  it "can set the value to false or nil" do
    subject.set false
    subject.value.must_equal false
  end

  describe "literal" do
    describe "as prompted by Attribute instance changes" do
      it "defaults the literal to no data type at all" do
        value = "Basic Value"
        subject.set value
        subject.literal.datatype.must_equal nil
        subject.literal.object.must_equal value
        subject.literal.value.must_equal value
      end

      it "handles a boolean as expected" do
        value = true
        subject.set value
        subject.literal.datatype.must_equal RDF::XSD.boolean
        subject.literal.object.must_equal value
        subject.literal.value.must_equal 'true'

        value = false
        subject.set value
        subject.literal.datatype.must_equal RDF::XSD.boolean
        subject.literal.object.must_equal value
        subject.literal.value.must_equal 'false'
      end

      it "handles a date as expected" do
        value = Time.now.to_date
        subject.set value
        subject.literal.datatype.must_equal RDF::XSD.date
        subject.literal.object.must_equal value
        subject.literal.value.must_equal value.to_s + "Z"
      end

      it "handles date_time as expected" do
        value = Time.now.to_datetime
        subject.set value
        subject.literal.datatype.must_equal RDF::XSD.dateTime
        subject.literal.object.must_equal value
        subject.literal.value.must_equal value.to_s
      end

      it "handles a decimal as expected" do
        value = 1.5
        subject.set value
        subject.datatype = RDF::XSD.decimal # Note, a plain decimal shows up as a double, rather than a decimal.
        subject.literal.datatype.must_equal RDF::XSD.decimal
        subject.literal.object.must_equal value
        subject.literal.value.must_equal "1.5"
      end

      it "handles a double as expected" do
        value = 1.5
        subject.set value
        subject.literal.datatype.must_equal RDF::XSD.double
        subject.literal.object.must_equal value
        subject.literal.value.must_equal "1.5"
      end

      it "handles time as expected" do
        value = Time.now
        subject.set value
        subject.literal.datatype.must_equal RDF::XSD.time
        subject.literal.object.must_equal value
        subject.literal.value.must_equal value.strftime("%H:%M:%S%Z")
      end

      # Note, I'm skipping token because the underlying RDF doesn't seem to work, and I don't
      # have a use case for it.
      # Also, I'm skipping XML because I don't have a use case for XML yet.
    end
    
    describe "as prompted by parameter changes" do
      it "defaults the literal to no data type at all" do
        value = "Basic Value"
        literal = subject.literal(:value => value)
        literal.datatype.must_equal nil
        literal.object.must_equal value
        literal.value.must_equal value
      end

      it "handles a boolean as expected" do
        value = true
        literal = subject.literal(:value => value)
        literal.datatype.must_equal RDF::XSD.boolean
        literal.object.must_equal value
        literal.value.must_equal 'true'
      
        value = false
        literal = subject.literal(:value => value)
        literal.datatype.must_equal RDF::XSD.boolean
        literal.object.must_equal value
        literal.value.must_equal 'false'
      end
      
      it "handles a date as expected" do
        value = Time.now.to_date
        literal = subject.literal(:value => value)
        literal.datatype.must_equal RDF::XSD.date
        literal.object.must_equal value
        literal.value.must_equal value.to_s + "Z"
      end
      
      it "handles date_time as expected" do
        value = Time.now.to_datetime
        literal = subject.literal(:value => value)
        literal.datatype.must_equal RDF::XSD.dateTime
        literal.object.must_equal value
        literal.value.must_equal value.to_s
      end
      
      it "handles a decimal as expected" do
        value = 1.5
        literal = subject.literal(:value => value, :datatype => RDF::XSD.decimal)
        literal.datatype.must_equal RDF::XSD.decimal
        literal.object.must_equal value
        literal.value.must_equal "1.5"
      end
      
      it "handles a double as expected" do
        value = 1.5
        literal = subject.literal(:value => value)
        literal.datatype.must_equal RDF::XSD.double
        literal.object.must_equal value
        literal.value.must_equal "1.5"
      end
      
      it "handles time as expected" do
        value = Time.now
        literal = subject.literal(:value => value)
        literal.datatype.must_equal RDF::XSD.time
        literal.object.must_equal value
        literal.value.must_equal value.strftime("%H:%M:%S%Z")
      end
    end
    
  end
  
  describe "to_rdf" do
    
    let(:model) do
      Class.new do
        def subject
          "http://example.com/demo/1"
        end
      end.new
    end
    
    subject { Attribute.new(:name => :name, :predicate => RDF::FOAF.name)}
    
    describe "as prompted from the Attribute instance" do
      it "uses the model subject" do
        rdf = subject.to_rdf(model)
        rdf.subject.must_equal model.subject
      end

      it "uses the attribute predicate" do
        rdf = subject.to_rdf(model)
        rdf.predicate.must_equal RDF::FOAF.name
      end

      it "uses the attribute value for object" do
        subject.set "George"
        rdf = subject.to_rdf(model)
        object = rdf.object
        object.to_s.must_equal "George"
        object.must_be_kind_of RDF::Literal
      end

      it "uses the language when provided" do
        subject.language = :es
        subject.set("Jorge")
        rdf = subject.to_rdf(model)
        rdf.object.language.must_equal :es
      end
      
      it "reverses the subject and object with reverse" do
        subject.reverse = true
        subject.set("George")
        rdf = subject.to_rdf(model)
        rdf.subject.to_s.must_equal "George"
        rdf.subject.must_be_kind_of RDF::Literal
        rdf.predicate.must_equal RDF::FOAF.name
        rdf.object.to_s.must_equal model.subject
        rdf.object.must_be_kind_of RDF::URI
      end
    end
    
    describe "as prompted from the call parameters" do
    end
    
  end
  

end
