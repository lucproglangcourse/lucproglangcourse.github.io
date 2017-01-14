The Functional Programming Paradigm
-----------------------------------

- project 0b and 1 clarifications 
  - [echotest-scala](https://github.com/lucproglangcourse/echotest-scala) example
  - TDD styles in Scala
- project 0c and 0d reminders
- [overview talk on PL history and paradigms](http://klaeufer.github.com/luc-amc.html)
  - Scala version of Haskell example from talk
  - [shootout benchmark](http://benchmarksgame.alioth.debian.org)
  - process tree [assignment](http://osdi.etl.luc.edu/homework/home-lab-assignment-1) and [examples in various languages](https://github.com/lucproglangcourse?q=processtree) including [Scala](https://github.com/lucproglangcourse/processtree-scala) - also guiding example for project 1
- console applications
  - role as composable building blocks in Unix (using pipes)
  - relationship with functional programming
  - importance of constant-space complexity
- scripting-style Scala: solving problems using built-in types and type constructors
  - tuples
  - collections
    - [`Option[_]`](scala-lang.org/api/current/index.html#scala.Option) and [`Try[_]`](http://scala-lang.org/api/current/index.html#scala.util.Try)
    - [`List[_]`](http://scala-lang.org/api/current/index.html#scala.collection.immutable.List) and [`Map[_, _]`](http://scala-lang.org/api/current/index.html#scala.collection.immutable.Map)
  - key methods: `map`, `filter`/`withFilter`, `find`, `flatMap`, `sum`, `fold`, `groupBy`
  - `for` comprehensions
  - [misc-explorations-scala](https://github.com/lucproglangcourse/misc-explorations-scala) examples


- object-oriented Scala (see also Swarts chapters 8 and 9)
  - can start by using Scala as a "better Java"
  - various improvements, including
    - [unified types](http://docs.scala-lang.org/tutorials/tour/unified-types.html)
    - [standalone objects](http://docs.scala-lang.org/tutorials/tour/singleton-objects.html)
    - [case classes](http://docs.scala-lang.org/tutorials/tour/case-classes.html) and [pattern matching](http://docs.scala-lang.org/tutorials/tour/pattern-matching.html)
    - [traits](http://docs.scala-lang.org/tutorials/tour/traits.html) (generalization of interfaces and restricted form of abstract classes, can be combined)
    - package structure decoupled from folder hierarchy
  - we'll study these features as we encounter them
  - examples below after discussing the next topic
- algebraic data types
  - fundamental building blocks: (disjoint) sum, product, arity, recursion, type parameters

        Shape = Circle(Int)
              | Rectangle(Int, Int)
              | Group(Seq(Shape))
              | Location(Int, Int, Shape)

    - nonrecursive, e.g. finite enumerations, boolean, option, try
    - sublinear, e.g. natural numbers
    - linear, e.g. list, map
    - nonlinear, e.g. tree, many custom domain models
  - separation of concerns
    - structure
    - content
    - traversal
    - processing
  - parametric polymorphism (genericitiy) as an orthogonal mechanism
  - expressing algebraic data types in an object-oriented language
  - key predefined collection data types *are* algebraic data types 
    - [`Option[_]`](scala-lang.org/api/current/index.html#scala.Option) and [`Try[_]`](http://scala-lang.org/api/current/index.html#scala.util.Try)
    - [`List[_]`](http://scala-lang.org/api/current/index.html#scala.collection.immutable.List) and [`Map[_, _]`](http://scala-lang.org/api/current/index.html#scala.collection.immutable.Map)
  - examples
    - process tree [original assignment](http://osdi.etl.luc.edu/homework/home-lab-assignment-1) and [examples](https://github.com/lucproglangcourse?utf8=%E2%9C%93&query=processtree)
    - [misc-explorations-scala](https://github.com/lucproglangcourse/misc-explorations-scala)
- project 1 discussion: 
  - imperative/mutable versus pure functional/immutable
  - modularization 
  - [processtree-scala](https://github.com/lucproglangcourse/processtree-scala) guiding example


 - algebraic data types (continued)
  - key predefined collection data types
    - [`Option[\_]`](scala-lang.org/api/current/index.html#scala.Option) and [`Try[_]`](http://scala-lang.org/api/current/index.html#scala.util.Try)
    - [`List[\_]`](http://scala-lang.org/api/current/index.html#scala.collection.immutable.List) and [`Map[\_, \_]`](http://scala-lang.org/api/current/index.html#scala.collection.immutable.Map)
    - key methods: `map`, `filter`/`withFilter`, `find`, `flatMap`, `sum`, `fold`, `groupBy`
    - `for` comprehensions
  - pattern matching in practice
  - examples
    - [expressions-oo-java](https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/expressions/SimpleExpressions.java)
    - [expressions-visitor-java](https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/vexpressions/VisitorExpressions.java)
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala)
    - [shapes-android-java](https://github.com/LoyolaChicagoCode/shapes-android-java)
    - [shapes-oo-scala project skeleton](https://github.com/lucproglangcourse/shapes-oo-scala)
    - process tree [original assignment](http://osdi.etl.luc.edu/homework/home-lab-assignment-1) and [examples](https://github.com/lucproglangcourse?utf8=%E2%9C%93&query=processtree)
    - [misc-explorations-scala](https://github.com/lucproglangcourse/misc-explorations-scala)
- project 2a discussion
- TDD styles in Scala and [echotest example](https://github.com/lucproglangcourse/echotest-scala) 

- (time permitting) brief heads-up on continuous integration/continuous delivery
  - https://travis-ci.org/LoyolaChicagoCode/processtree-scala
  - https://coveralls.io/github/LoyolaChicagoCode/processtree-scala
  - https://github.com/LoyolaChicagoCode/scalamu
  - https://www.codacy.com/public/laufer/scalamu/dashboard
  - http://issuestats.com/github/LoyolaChicagoCode/scalamu



 - algebraic data types (continued)
  - algebraic data types in practice
    - case classes/objects
    - pattern matching
    - built-in methods
    - external behaviors ([Visitor pattern](https://sourcemaking.com/design_patterns/visitor))
  - examples
    - [expressions-oo-java](https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/expressions/SimpleExpressions.java)
    - [expressions-visitor-java](https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/vexpressions/VisitorExpressions.java)
    - [expressions-scala](https://github.com/lucproglangcourse/expressions-scala)
    - [shapes-android-java](https://github.com/LoyolaChicagoCode/shapes-android-java)
    - [shapes-oo-scala project skeleton](https://github.com/lucproglangcourse/shapes-oo-scala)
    - process tree [original assignment](http://osdi.etl.luc.edu/homework/home-lab-assignment-1) and [examples](https://github.com/lucproglangcourse?utf8=%E2%9C%93&query=processtree)
    - [misc-explorations-scala](https://github.com/lucproglangcourse/misc-explorations-scala) org chart examples


  - tuple versus sequence/list
  - `map` versus `flatMap`
  - `for` comprehensions
  - console applications as composable building blocks in Unix (using pipes)
  - importance of constant-space complexity for scalability

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



