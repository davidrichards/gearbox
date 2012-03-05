require_relative '../spec_helper'

include Example

describe Theme do
  
  subject { Theme.new() }

  it "has a name getter and setter" do
    subject.name = "Dolphins"
    subject.name.must_equal("Dolphins")
  end
  
  it "has a tally getter and setter" do
    tally = 3
    subject.tally = tally
    subject.tally.must_equal(tally)
  end

end

=begin

Steps That May Work
===================

* Read up on various implementations for RDF
* Mix in model -> RDF via serialization class and some builder methods
* Read up on various implementations for SPARQL
* Build some query objects to do full CRUD on these models
* Read the LOD code
* Implement a mix in for properties and associations
* Build a half-dozen minimal models with the new infrastructure

Implementing RDF
================

What are the types of serialization?
------------------------------------

The [JSON](https://github.com/gkellogg/rdf-json) gem is about representing the triples in plain JSON.  It is more-nested, with fewer conventions.

The [JSON::LD](http://json-ld.org/) is JSON for Linked Data.  It has a playground for building this stuff and learning how this can be used.  It is meant to be as accessible as anything we'd use in a client application.

The [Microdata](https://github.com/gkellogg/rdf-microdata) gem is about annotating HTML with microdata.  I think I'd rather go with rdfa and [Schema.org](http://schema.org/) instead.

The [RDFa](https://github.com/gkellogg/rdf-rdfa) stuff is more promising.  There is a [good article](http://semanticweb.com/introduction-to-rdfa-2_b26361) about using this in practical terms.  This is the [Schema.org](http://schema.org/) stuff.  

[N3](http://www.w3.org/2001/sw/RDFCore/ntriples/) or N-Triples are a long-winded serialization format.  The [RDF Library](https://github.com/gkellogg/rdf-n3) is straightforward and useful. As far as I know, N-Quads are triples + context.

There are others that I don't understand as well: RDF-XML, Trig, Trix, and Turtle.

This comes down to understanding which types of serialization to use.  Which to use, any why? I think Turtle is terse and easy to ready for humans.  There are abbreviations and aliases and punctuation that make it fairly straight forward.  

RDF::XML is verbose and possibly a pain in the ass.  Why make it so complicated?  If we had other XML tools that we wanted to use, that would be fine.  As far as I'm concerned, SPARQL is more powerful than any other set of XML tools.  So, no thanks.

As far as interoperability goes, it shouldn't matter.  Any SPARQL end point or semantic application should be able to consume anything.  So, the RDF.rb tools can consume a format that I'm not in love with, and I can produce an RDF format that's easiest to use.

I've wondered about the JSON formats: RDF::JSON and RDF::JSON-LD.  What possible use could I have for dealing with this in JSON?  If I hada Node.js application, then I would have to implement some of the same tools I have in RDF.rb in JavaScript.  If I was sending this to the client, I have the same problem.  There might be a case for accepting a graph and producing some schema.org or microdata HTML.  With a rich Internet application, templates, and that sort of thing, I think there's a strong use case for that format.  

But Why?
-------

I spent some real time working on why I'm so interested in Semantic data right now. I am experiencing pain right now.  I am lost.  I feel like I spend a lot of time looking at important things.  I feel like I forget more than I remember.  I don't think I have a problem with my memory, I'm just front-loading exponentially more information than I typically do.  And, I want to work on this problem. 

Why am I experiencing pain?  I'm trying to get pregnant with a product right now.  I'm working on audiences and their pain and their watering holes and their needs and the ways they make money.  I am addressing these things, and finding that I have not found myself equal to the task?

Why are you not equal to the task?  There are two issues here, the first is that it takes a lot of deep-seated knowledge to move forward.  That, and guts.  Guts, I'll have to deal with.  The knowledge, I need to get my head around things.

This is what they call shaving your yak.  It's a task before a task.  It's a way to get ready to get ready.  It can be a colosal waste of time, a panty-waste way to do life.  It can also be necessary.  It takes wisdom to know the difference.  That is why I'm typing right now, to listen to that wisdom.

If I had the perfect modeling system, then what?

* I could record little things.  I'd want to have the tree browser to go over things by hand.  I'd want to have topics and tallys and people and sites and themes.  I'd want to have full-text indices on various axes where decisions are made.  I'd want to have auto correct tools built off of these indices to keep things neat and orderly.
* I'd want to have some good inference tools around.  I'd want to know why all this matters.  I'd want to see the forest from the trees.

Audience | Event | Question
  name
  Resource
    location
    Person
      name
      tweet account | email | website | phone
    Theme
      name
      tally
  
As a result:

* What themes arise amongst this adience|event|question?
* Who is involved in this theme? What proportion are they of X, where X can be almost anything? How likely is someone likely to believe X, if they are associated with this audience|event|question? 
* How do I find X?
* Does X know Y?
* How is X connected to Y?
* Of the people in X, which ones hold more sway?  How do I reach these people?
* If I were to fill a jury, and wanted them to believe X, what other attributes would I look for to know that they are in audience Y?
* Can I express all of these questions in terms of graphical models, conditional probabilities, and Bayesian inference?

At this point, we are very explicit with our world.  At this point, if my reading blog articles and tweet feeds could give me this kind of re-usability, I'd do it all day long.

Another scenario, Research
--------------------------

I read an incindiary blog article.  I'm pissed.  I want to rip this person a new one.  Now what?

* What opinions do I have that tell me this guy is full of shit?
* How can I support these opinions?

That's really it. I'll need a way to do:

Question
  title
  Answer
    body
    Measure (some sort of graphical model, likely stemming from other main-line research)
      amount
  Conclusion
    body
    
The Patthern
===========

So, I've realized that the pattern is mundane -> summarized -> insightful.  I'd like to go around making mundane little messages and tallies as I work through life, and have a way to respond with insightful conversation as a consequence.
    

How to build triples?
---------------------

What kinds of repositories are there?
-------------------------------------

Is this information useful if I'll have a SPARQL endpoint any way?
------------------------------------------------------------------


=end

