The Functional Programming Paradigm
-----------------------------------

In this chapter, we study the functional programming paradigm, with examples and projects mostly in Scala.


Defining abstractions in imperative and object-oriented languages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In imperative and object-oriented languages, the basic abstractions are

- addressing: pointers, references
- aggregation: structs/records, arrays

  - example: node in a linked list

- variation: tagged unions, multiple implementations of an interface

  - example: mutable set abstraction

    - add element
    - remove element
    - check whether an element is present
    - check if empty
    - how many elements
  - several possible implementations

    - reasonable: binary search tree, hash table, bit vector (for small underlying domains)
    - less reasonable: array, linked list
    - see also this `table of collection implementations <http://docs.oracle.com/javase/tutorial/collections/implementations>`_

In an object-oriented language, we commonly use a combination of design patterns (based on these basic abstractions) to represent structures and associated behaviors:

- https://github.com/lucoodevcourse/shapes-android-java 
- https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/expressions/SimpleExpressions.java
- https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/vexpressions/VisitorExpressions.java


Object-oriented Scala as a "better Java"
````````````````````````````````````````

Scala offers various improvements over Java, including:

- `unified types <http://docs.scala-lang.org/tutorials/tour/unified-types.html>`_
- `standalone higher-order functions <http://docs.scala-lang.org/tutorials/tour/higher-order-functions>`_
- `standalone objects <http://docs.scala-lang.org/tutorials/tour/singleton-objects.html>`_
- `case classes <http://docs.scala-lang.org/tutorials/tour/case-classes.html>`_ and `pattern matching <http://docs.scala-lang.org/tutorials/tour/pattern-matching.html>`_
- `traits <http://docs.scala-lang.org/tutorials/tour/traits.html>`_: generalization of interfaces and restricted form of abstract classes, can be combined/stacked
- package structure decoupled from folder hierarchy
- `higher-kinded types <https://earldouglas.com/posts/higher-kinded.html>`_ (advanced topic)

More recent versions of Java, however, have started to echo some these advances:

- lambda expressions
- default methods in interfaces

We will study these features as we encounter them. 

.. todo:: examples below after discussing the next topic

  
Defining algebraic data types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Most abstractions fall into one of these categories:

- nonrecursive/scalars: boolean, finite enumerations (including numeric types), try
- sublinear structures: (infinite set of) natural numbers, option
- linear structures: lists, maps
- nonlinear structures: trees, graphs, many custom domain models

The fundamental building blocks of these *algebraic data types* are related to those discussed above:

- (disjoint) sum: variation
- product (tuple, record) of a given arity: aggregation
- recursion (at the type level)
- type parameters (genericity)

  
Using these building blocks, we can express `Shape` from the examples above as an algebraic data type::

        Shape = Circle(Int)
              | Rectangle(Int, Int)
              | Group(Seq(Shape))
              | Location(Int, Int, Shape)

We can separately define behaviors on Shapes as functions. Here is an example that illustrates this approach:

- https://github.com/lucproglangcourse/shapes-oo-scala 
- https://github.com/lucproglangcourse/expressions-scala 


We are able to achieve a separation of the following structural and behavioral concerns:

- structure
- content
- traversal
- processing


  
Behaviors on algebraic data types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following are additional examples of behaviors on algebraic types. For recursive types, the behaviors are typically recursive as well.


- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/nat.sc
- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnLists.sc
- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchart.sc
- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchartGeneric.sc 
- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/factorial.sc
  


Solving problems using built-in types and type constructors
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As do other languages, Scala provides an extensive library of predefined types and (generic) type constructors. Many of these, especially collection types and certain utility types, *are* algebraic data types:

- ``Seq`` / ``List``

  - http://scala-lang.org/api/current/index.html#scala.collection.immutable.List
  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/lists.sc
  - note the difference between those and tuples

- ``Map``

  - http://scala-lang.org/api/current/index.html#scala.collection.immutable.Map

- ``Option`` / ``Either``

  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/option.sc
  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/either.sc 
  - http://robsscala.blogspot.com/2012/06/fixing-scalaeither-unbiased-vs-biased.html 

- ``Try``

  - http://scala-lang.org/api/current/index.html#scala.util.Try
  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/try.sc

Using Scala like a scripting language (such as Python or Ruby), one can solve many problems without even defining custom algebraic data types, except perhaps the occasional tuple.
The main building blocks in scripting-style Scala are the collection and utility types we just mentioned, along with

- key methods ``map``, ``filter`` / ``withFilter``, ``find``, ``flatMap``, ``sum``, ``fold``, ``groupBy``, ``collect``
- ``for`` comprehensions


Examples
````````

  
Loop over a finite collection or iterator using mutable state::

  final Iterator<String> incoming = ...;
  int sum = 0;
  int count = 0;
  for (final String s: incoming) {
    sum += s.length();
    count += 1; 
  }
  final float result = (float) sum / count;


Immutable equivalent using ``foldLeft``::

  val (sum, count) = incoming.foldLeft {
    (0, 0)
  } { case ((sum, count), next) =>
    (sum + next.length, count + 1)
  }
  val result = sum.toFloat / count


Unbounded loop until a condition is met::

  while ((/* ... */ ; line = reader.readLine()) != null ; line) {
    processExpr(line)
  }


Immutable equivalent using ``continually``::

  Iterator continually {
    // ...
    reader.readLine()
  } takeWhile {
    Option(_).isDefined
  } foreach {
    processExpr
  }


Note that we are using ``foreach`` when the body of the iteration produces a *side effect* such as output.
If we wanted to compute a *result value*, we could instead use ``continually`` with ``foldLeft``.

Note also that all of these are methods but look like control structures because of Scala's syntax, which allows you to omit the dot in certain cases of method selection and to use curly braces instead of round parentheses to delimit your argument list.
  
The more familiar one becomes with the various predefined building blocks, the more quickly and productively one can put together at least an initial solution to a problem.
Earlier versions of the `process tree <https://github.com/lucproglangcourse/processtree-scala>`_ example illustrates this style, while later versions reflect greater emphasis on code quality, especially testability and avoidance of code duplication.
  


Content below under construction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


- (time permitting) brief heads-up on continuous integration/continuous delivery
  - https://travis-ci.org/LoyolaChicagoCode/processtree-scala
  - https://coveralls.io/github/LoyolaChicagoCode/processtree-scala
  - https://github.com/LoyolaChicagoCode/scalamu
  - https://www.codacy.com/public/laufer/scalamu/dashboard
  - http://issuestats.com/github/LoyolaChicagoCode/scalamu



  - `map` versus `flatMap`
  - `for` comprehensions


- recap of predefined list operations
  - keep in mind that [lists are head/tail-optimized](http://www.scala-lang.org/api/current/index.html#scala.collection.immutable.List)
  - observations
    - `foldLeft` is usually what we want: *linear-time* and *constant-space* (tail-recursive)
    - `foldRight` is *linear-time* and *linear-space* (*not* tail-recursive) but goes with the natural head-tail structure of the list
    - `xs.foldRight(z)(f) == xs.reverse.foldLeft(z)(g)` where `g` is `f` with the arguments switched
  - Scala library implementations of these functions 
    - find desired method in documentation, expand, and look at *definition classes*
    - these tend to appear more complex than expected for performance reasons
    - [`foreach`](https://github.com/scala/scala/blob/v2.11.7/src/library/scala/collection/immutable/List.scala#L378)
    - [`foldLeft`](https://github.com/scala/scala/blob/v2.11.7/src/library/scala/collection/TraversableOnce.scala#L153)
    - [`reverse`](https://github.com/scala/scala/blob/v2.11.7/src/library/scala/collection/immutable/List.scala#L386)
    - [`foldRight`](https://github.com/scala/scala/blob/v2.11.7/src/library/scala/collection/immutable/List.scala#L396)
    - [`map`](https://github.com/scala/scala/blob/v2.11.7/src/library/scala/collection/immutable/List.scala#L270)
    - [`length`](https://github.com/scala/scala/blob/v2.11.7/src/library/scala/collection/LinearSeqOptimized.scala#L49)
  - *challenge*: can we write (efficiently or not)
    - `length`, `sum`, `reverse`, `filter`, `find`, `map` as fold?
    - fold as `map`?!?
  - efficiency considerations in more detail -> next week
    - [space complexity, tail recursion, and accumulators](http://blog.emielhollander.nl/tail-recursion-and-the-accumulator-in-scala/)
    - [tail recursion, trampolines, and continuations](http://blog.richdougherty.com/2009/04/tail-calls-tailrec-and-trampolines.html) (advanced) 
  - observations
    - *fold* handles the *traversal* concern and separates it from the *processing* concern (goes a step further than the visitor pattern)
    - domain and codomain of *fold*?
    - domain and codomain of *map*?

- writing our own (recursive) functions on options, lists, streams, and other algebraic data types -> next week
  - examples
    - [factorial](https://github.com/LoyolaChicagoCode/misc-explorations-scala/blob/master/factorial.sc)
    - [functions on lists](https://github.com/LoyolaChicagoCode/misc-explorations-scala/blob/master/functionsOnLists.sc)
    - [functions on streams](https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnStreams.sc)
    - [functions on simple natural numbers](https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/nat.sc)
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala)
  - observations
    - the `Y`-combinator handles the *recursion* concern *for behaviors* and separates it from the concern of what should happen in each step of the recursion

- formalizing algebraic data types as initial F-algebras
  - concepts -> next week
    - [(endo)functor](https://hseeberger.wordpress.com/2010/11/25/introduction-to-category-theory-in-scala)
    - [F-algebra](https://www.fpcomplete.com/user/bartosz/understanding-algebras)
    - fold = catamorphism
    - the `µ`-combinator handles the *recursion* concern *for structures* and separates it from the nature of the structure itself
    - F-coalgebra
    - unfold = anamorphism
  - practical applications -> next week
  - examples
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala) versus [expressions-algebraic-scala](https://github.com/lucproglangcourse/expressions-algebraic-scala)
    - [Scalaµ library](https://github.com/lucproglangcourse/scalamu) and [examples](https://github.com/lucproglangcourse/scalamu/examples)

- project 2b discussion

(time permitting) 

- TDD styles in Scala and [echotest example](https://github.com/lucproglangcourse/echotest-scala) 
- brief heads-up on continuous integration/continuous delivery -> probably next week
  - https://travis-ci.org/LoyolaChicagoCode/processtree-scala
  - https://coveralls.io/github/LoyolaChicagoCode/processtree-scala
  - https://github.com/LoyolaChicagoCode/scalamu
  - https://www.codacy.com/public/laufer/scalamu/dashboard
  - http://issuestats.com/github/LoyolaChicagoCode/scalamu

# References

- [Understanding F-Algebras](https://www.fpcomplete.com/user/bartosz/understanding-algebras)
- [Gibbons](https://www.cs.ox.ac.uk/jeremy.gibbons/publications/origami.pdf) (advanced)
- [Oliveira & Cook](http://www.cs.utexas.edu/~wcook/Drafts/2012/ecoop2012.pdf) (advanced)



  
- efficiency considerations for predefined list operations in more detail
  - [space complexity, tail recursion, and accumulators](http://blog.emielhollander.nl/tail-recursion-and-the-accumulator-in-scala/)
  - [tail recursion, trampolines, and continuations](http://blog.richdougherty.com/2009/04/tail-calls-tailrec-and-trampolines.html) (advanced) 

- writing our own (recursive) functions on options, lists, streams, and other algebraic data types
  - examples
    - [factorial](https://github.com/LoyolaChicagoCode/misc-explorations-scala/blob/master/factorial.sc)
    - [functions on lists](https://github.com/LoyolaChicagoCode/misc-explorations-scala/blob/master/functionsOnLists.sc)
    - [functions on streams](https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnStreams.sc)
    - [functions on simple natural numbers](https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/nat.sc)
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala)
  - observations
    - the `Y`-combinator handles the *recursion* concern *for behaviors* and separates it from the concern of what should happen in each step of the recursion

- formalizing algebraic data types as initial F-algebras
  - concepts
    - [(endo)functor](https://hseeberger.wordpress.com/2010/11/25/introduction-to-category-theory-in-scala): type constructor that satisfies *identity* and *composition* laws
    - the `µ`-combinator handles the *recursion* concern *for structures* and separates it from the nature of the structure itself
    - fold = catamorphism `cata` for breaking down a data structure to a result value
    - [F-algebra](https://www.fpcomplete.com/user/bartosz/understanding-algebras): argument to fold, has functor `F` and carrier object (= result type of the fold)
    - `unfold` = anamorphism for building up a data structure
    - F-coalgebra: argument to unfold (generator), also has functor `F` and carrier object (= type of seed and generated values wrapped in functor)
  - practical applications
  - examples
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala) versus [expressions-algebraic-scala](https://github.com/lucproglangcourse/expressions-algebraic-scala)
    - [Scalaµ library](https://github.com/lucproglangcourse/scalamu) and [examples](https://github.com/lucproglangcourse/scalamu/examples)

- [project 2b](https://trello.com/c/EihkYkGP/59-project-2b) clinic
- project 3a overview
- 16:30-16:45 student presentation on C++
- 16:45-17:15 presentation by alumna and part-time faculty member María Sáenz

(time permitting) 

- TDD styles in Scala and [echotest example](https://github.com/lucproglangcourse/echotest-scala) 
- brief heads-up on continuous integration/continuous delivery -> probably next week
  - https://travis-ci.org/LoyolaChicagoCode/processtree-scala
  - https://coveralls.io/github/LoyolaChicagoCode/processtree-scala
  - https://github.com/LoyolaChicagoCode/scalamu
  - https://www.codacy.com/public/laufer/scalamu/dashboard
  - http://issuestats.com/github/LoyolaChicagoCode/scalamu



- recap: formalizing algebraic data types as initial F-algebras
  - concepts
    - [(endo)functor](https://hseeberger.wordpress.com/2010/11/25/introduction-to-category-theory-in-scala): type constructor that satisfies *identity* and *composition* laws
    - the `µ`-combinator handles the *recursion* concern *for structures* and separates it from the nature of the structure itself
    - fold = catamorphism `cata` for breaking down a data structure to a result value
    - [F-algebra](https://www.fpcomplete.com/user/bartosz/understanding-algebras): argument to fold, has functor `F` and carrier object (= result type of the fold)
    - `unfold` = anamorphism for building up a data structure
    - F-coalgebra: argument to unfold (generator), also has functor `F` and carrier object (= type of seed and generated values wrapped in functor)
  - practical applications
  - examples
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala) versus [expressions-algebraic-scala](https://github.com/lucproglangcourse/expressions-algebraic-scala)
    -  [project 2a](https://trello.com/c/nPaqQAJf/58-project-2a) versus [project 2b](https://trello.com/c/EihkYkGP/59-project-2b)
  - key insights
    - commonalities among recursive types
      -  `µ`-based: `Nat`, `Expr`, `Shape`, etc.
      -  `Cofree`-based: `List`, `Tree`, `OrgChart`, etc.
      - how are, say, `Option`, `List`, and `Tree` related?
      - structural
      - behavioral
      - potential for code reuse 
        - [Scalaµ library](https://github.com/lucproglangcourse/scalamu)
        - [Scalaz library](https://github.com/scalaz/scalaz)



