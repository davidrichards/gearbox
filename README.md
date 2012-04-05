Gearbox
=======

The purpose of this project is to make it easier for me to curate semantic graphs.  I'm looking for deeper satisfaction in my personal research.  I tend to fill my days researching technology, market dispositions, and my own business documents.  These types of data stores, of course, could be applied in many areas.

To get to wherever I am now, I've been playing with semantic models for a while.  I started by demonstrating working code from various corners of my imagination.  After a while, I thought I had enough to create a useful gem.  In the past, I've worked with [Spira](https://github.com/bhuga/spira) and examples given by [Gregg Kellogg](http://greggkellogg.net/).  These have been very useful in forming ideas.

As I worked on this code, I decided to go to [Spira](https://github.com/bhuga/spira) to see how similar the two gems are.  I've read Ben's code a dozen times before, but this time I was surprised how similar they actually are.  The similarities are:

* both are ORMs for semantic data, written in Ruby
* support for properties/attributes
* concept of model associations
* data validations
* value types

However, Gearbox is quite a bit different.  It came from a different place.  I've been trying to embrace the nature of semantic models (or find a way to express my imagination with semantic tools).  The major differences, I imagine are:

* support for SPARQL-based scopes and finder methods
* better support for working with various SPARQL end points
* creating and maintaining full-text indices
* object factory from triples

Practical Example
=================

It would be good to offer a practical example.  I'll get to these in a bit.  Probably these will start appearing around version 0.2 or 0.3.  They probably won't be very exciting until around version 0.4.

Road Ahead
==========

* bring in the associations and type system (related, believe it or not)
* implement mutability (version 0.2)
* workflows with SPIN and full-text indexing (version 0.3)
* exploration utilities (version 0.4)

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
