# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gearbox"
  s.version = "0.1.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Richards"]
  s.date = "2012-04-05"
  s.description = "A SPARQL-driven modeling toolset for semantic models."
  s.email = "davidlamontrichards@gmail.com"
  s.executables = ["gearbox"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.html",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Guardfile",
    "LICENSE.txt",
    "README.html",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/gearbox",
    "gearbox.gemspec",
    "lib/gearbox.rb",
    "lib/gearbox/attribute.rb",
    "lib/gearbox/attribute_collection.rb",
    "lib/gearbox/mixins/active_model_implementation.rb",
    "lib/gearbox/mixins/ad_hoc_properties.rb",
    "lib/gearbox/mixins/queryable_implementation.rb",
    "lib/gearbox/mixins/resource.rb",
    "lib/gearbox/mixins/semantic_accessors.rb",
    "lib/gearbox/mixins/subject_methods.rb",
    "lib/gearbox/rdf_collection.rb",
    "lib/gearbox/type.rb",
    "lib/gearbox/types.rb",
    "lib/gearbox/types/any.rb",
    "lib/gearbox/types/boolean.rb",
    "lib/gearbox/types/date.rb",
    "lib/gearbox/types/decimal.rb",
    "lib/gearbox/types/float.rb",
    "lib/gearbox/types/integer.rb",
    "lib/gearbox/types/native.rb",
    "lib/gearbox/types/string.rb",
    "lib/gearbox/types/uri.rb",
    "lib/gearbox/vocabulary.rb",
    "lib/pry_utilities.rb",
    "scratch/4s.rb",
    "scratch/DEVELOPMENT_NOTES.md",
    "scratch/actionable.md",
    "scratch/ccrdf.html-rdfa.nq",
    "scratch/foo.rb",
    "scratch/index.rdf",
    "scratch/j2.rb",
    "scratch/junk.rb",
    "scratch/out.rb",
    "spec/gearbox/attribute_collection_spec.rb",
    "spec/gearbox/attribute_spec.rb",
    "spec/gearbox/mixins/active_model_implementation_spec.rb",
    "spec/gearbox/mixins/ad_hoc_properties_spec.rb",
    "spec/gearbox/mixins/queryable_implementation_spec.rb",
    "spec/gearbox/mixins/resource_spec.rb",
    "spec/gearbox/mixins/semantic_accessors_spec.rb",
    "spec/gearbox/mixins/subject_methods_spec.rb",
    "spec/gearbox/rdf_collection_spec.rb",
    "spec/gearbox_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/davidrichards/gearbox"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.18"
  s.summary = "Flexible semantic models."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<linkeddata>, [">= 0"])
      s.add_runtime_dependency(%q<sparql>, [">= 0"])
      s.add_runtime_dependency(%q<equivalent-xml>, [">= 0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 0"])
      s.add_runtime_dependency(%q<pry>, [">= 0"])
      s.add_runtime_dependency(%q<autotest-fsevent>, [">= 0"])
      s.add_runtime_dependency(%q<autotest-growl>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<guard-markdown>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_development_dependency(%q<guard-minitest>, [">= 0"])
    else
      s.add_dependency(%q<linkeddata>, [">= 0"])
      s.add_dependency(%q<sparql>, [">= 0"])
      s.add_dependency(%q<equivalent-xml>, [">= 0"])
      s.add_dependency(%q<activemodel>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<autotest-fsevent>, [">= 0"])
      s.add_dependency(%q<autotest-growl>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<guard-markdown>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<guard-minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<linkeddata>, [">= 0"])
    s.add_dependency(%q<sparql>, [">= 0"])
    s.add_dependency(%q<equivalent-xml>, [">= 0"])
    s.add_dependency(%q<activemodel>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<autotest-fsevent>, [">= 0"])
    s.add_dependency(%q<autotest-growl>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<guard-markdown>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<guard-minitest>, [">= 0"])
  end
end

