require_relative '../../spec_helper'

include Gearbox

describe SubjectMethods do
  
  before do
    @class = Class.new do
      include SubjectMethods
    end
  end

  let(:base_uri) { "http://example.com" }
  subject { @class.new }
  
  # =============
  # = ID Method =
  # =============
  it "can define the id_method on the class level" do
    @class.id_method :new_id
    @class.id_method.must_equal :new_id
  end
  
  it "defaults id_method to :object_id" do
    @class.id_method.must_equal :object_id
  end
  
  it "can set the id_method at initialization" do
    subject = @class.new(:id_method => :new_id)
    subject.id_method.must_equal(:new_id)
  end

  it "defaults the id to object_id" do
    subject.id.must_equal subject.object_id
  end

  it "uses id_method to define which method sets the id" do
    def subject.new_id; :new_id; end
    subject.id_method = :new_id
    subject.id.must_equal :new_id
  end
  
  # ======
  # = Id =
  # ======
  it "has an id setter" do
    subject.id = :whale
    subject.id.must_equal :whale
  end
  
  it "can set the id at initialization" do
    subject = @class.new(:id => "george")
    subject.id.must_equal "george"
  end
  
  # ============
  # = Base URI =
  # ============
  it "can define the base_uri on the class level" do
    @class.base_uri base_uri
    @class.base_uri.must_equal base_uri
  end
  
  it "can set the base_uri at initialization" do
    subject = @class.new(:base_uri => base_uri)
    subject.base_uri.must_equal base_uri
  end
  
  it "can set the base_uri as a normal accessor" do
    subject.base_uri = "http://weird.com"
    subject.base_uri.must_equal "http://weird.com"
  end
  
  it "defaults to the class.base_uri" do
    @class.base_uri base_uri
    subject = @class.new
    subject.base_uri.must_equal base_uri
  end
  
  # =====================
  # = Subject Decorator =
  # =====================
  it "can define the subject_decorator on the class level" do
    @class.subject_decorator :spoofy
    @class.subject_decorator :spoofy
  end
  
  it "can set the subject_decorator at initialization" do
    subject = @class.new(:subject_decorator => :spoofy)
    subject.subject_decorator.must_equal :spoofy
  end
  
  it "can set the subject_decorator as a normal accessor" do
    subject.subject_decorator = :spoofy
    subject.subject_decorator.must_equal :spoofy
  end
  
  it "default to the class.subject_decorator" do
    @class.subject_decorator :spoofy
    subject = @class.new
    subject.subject_decorator.must_equal :spoofy
  end
  
  # ===========
  # = Subject =
  # ===========
  it "has a default subject method that combines the base_uri with the id" do
    subject.base_uri = base_uri
    subject.id = "george"
    subject.subject.must_equal "#{base_uri}/george"
  end
  
  it "uses the subject_decorator if it is set" do
    def subject.special_case; "#{base_uri}/special/#{id}"; end
    subject.subject_decorator = :special_case
    subject.base_uri = "http://example.com"
    subject.subject.must_equal subject.special_case
  end
  
  it "can use a lambda for a subject_decorator" do
    subject.subject_decorator = lambda{|model| "#{model.base_uri}/special/#{model.id}"}
    subject.base_uri = "http://example.com"
    subject.subject.must_equal "http://example.com/special/#{subject.id}"
  end

end
