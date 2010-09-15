## Just Doo It

Doo is an experiment in taking a relentlessly polymorphic approach to deployment scripting. Like most deployment tools, doo lets you define executable blocks of deployment code independent of the configuration particulars that get bound into them at runtime. Where doo is different is in its succinctness (its core is just shy of 100 LoC), and in its use of polymorphism to realize stacking contexts. This lets you do useful things like defining configuration parameters on a project-wide, server-specific, and even task-specific level without having to rewrite (or doctor the hell out of) your deployment code.

Because executable blocks are also polymorphic, you can mix and match provider blocks into your recipes. Want to have one deployment recipe for local and remote targets? No problem. Want to abstract away the particulars of your server's OS? We can do that, too.
 
Doo layers a thin DSL that facilitates polymorphic behaviour on top of bare Ruby, and leans on a small number of built-in (and optional) deployment recipes to provide useful functionality.

## Play With It

    gem install doo

Check out examples/sample.rb to get started.

## LICENSE

(The MIT License)

Copyright (c) 2010 Mat Trudel

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
