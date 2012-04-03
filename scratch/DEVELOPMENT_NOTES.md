Current Issues
==============

* ActiveModel
* Mutable
* Serialization
* Query-Driven Everything
* Clean Up

Mutable
=======

It's time to start saving things.  I need to mix in the mutability 
Serialization
=============

This is to get models and associations out of queries, but not validations or SPIN statements.  The issues I should visit (in the AM):

* the amount of delegation (can I simplify with ActiveModel attributes?)
* defining some conventions for assigning triples as attributes
* defining some conventions for the seams on associations
* using attribute options (reverse, default, type) when serializing (possibly done)

ActiveModel
===========

The first step is to change over to the new interface.  Look at the SemanticSafari models for those examples.  

* subject syntax
* attribute
* association -> ???

Features I'll adopt:

* attribute methods: prefix methods, attr_accessor
* callbacks
* dirty: track value changes
* errors: add errors
* naming: model_name, model_name.human
* serializable: ???
* validation: SPARQL-driven


Query-Driven Everything
=======================

* The main find/all
* Any named scopes
* Ad hoc queries
* Validations
* SPIN and backoffice extension
* specific find/all (id-driven, conditional, anything I build along these lines)

Some of this will interact with the full-text queries.  Meaning, I can't do all of this at once.  

Clean Up
========

* Ad Hoc (needed/wanted, refactor?)
* Semantic Accessors (name?)

Repositories
============

* Configuration
* Dydra


scenarios:
  
  when designing a model
  when entering data
  when validating a model
  when saving a model
  when finding and initiating models
  when performing offline enhancement
  when managing a full-text index
  when linking to SPARQL end points
  when building an ontology reference
  
  when publishing semantic data
  when using with form_for
  when dealing with mass assignment
  when serializing to non-semantic forms (RDF-ignorant client)
  
