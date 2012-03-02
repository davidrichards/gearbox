Gearbox
=======

The purpose of this project is to make it easier for me to curate semantic graphs.  I'm looking for deeper satisfaction in my personal research.  I tend to fill my days researching technology, market dispositions, and my own business documents.  These types of data stores, of course, could be applied in many areas.

To get to wherever I am now, I've been playing with semantic models for a while.  I started by demonstrating working code from various corners of my imagination.  After a while, I thought I had enough to create a useful gem.  In the past, I've worked with [Spira](https://github.com/bhuga/spira) and examples given by [Gregg Kellogg](http://greggkellogg.net/).  These have been very useful in forming ideas.

As I worked on this code, I decided to go to [Spira](https://github.com/bhuga/spira) to see how similar the two gems are.  I was surprised how similar they actually are.  The similarities are:

* both are ORMs for semantic data, written in Ruby
* support for properties/attributes
* concept of model associations
* data validations
* value types

However, Gearbox is quite a bit different.  It came from a different place.  I've been trying to embrace the nature of semantic models.  This, juxtaposed against relational models or other types of models.  The major differences, I imagine are:

* support for SPARQL-based scopes and finder methods
* better support for working with various SPARQL end points
* creating and maintaining full-text indices
* object factory from triples

Development Workflow for Semantic Data
======================================

For a typical domain, I test-drive some models to define the nature of the data.  These are custom-built to support the user scenarios and behavior an application is built to serve.  For semantic models, I'm going for something different.  The relationships between resources are much more dynamic.  It's tough to build an application on dynamic domain models.  

To work with this, I optimize for different things.  Instead of trying to canonize the data, I try to concretize the interaction.  Given a head/buffer/file full of data, what's the easiest way to save it?  Which values have to be recorded?  Which values can be inferred or classified offline?  

I think that there's going to be an evolution of the data graph.  I'm looking to start with the mundane, and hope to be able to create a broad view from the details collected.  Possibly, I will have alternative broad views, such as a full view of the topic or a chronological account of the topic as it transpires.  From here, I want to look for insightful information: inferences that show the nature of our subject.  

That's the goal.

Practically, the work changes over time.  We start with defining the attributes and associations that are needed.  This is the mundane.  We then start to qualify the data by writing validations.  Probably, there will be overlapping models to reflect the interaction.  For example, browsing email might have a cursory recording of the people involved.  Looking up Twitter information might have a more-specific user model.  Facebook, the same.  We're building a summary of the users, or whatever we're studying.  From here, we might be able to use various analytical methods to classify and enhance the models, to clarify the story we are able to gather.

As you can see, this is a very different process than something we might do with typical relational data.  I don't think there is much that we do with semantic data that can't be done with relational data, it's just that the technologies are optimized for different purposes.

Practical Example
=================

It would be good to offer a practical example.  I'll get to these in a bit.  I don't need to have the documentation get ahead of the released code.

TODO
====

This is a rough list.  The RDF.rb mind map has a few more details.

* bring in the association and combination code
* implement mutability
* implement persistence
* implement queryable
* implement named scopes
* implement some sort of repository access
* use Gearbox in the examples (were written to concretize an example in my head)

Contributing to Gearbox
=======================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========

Copyright (c) 2012 David Richards

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
