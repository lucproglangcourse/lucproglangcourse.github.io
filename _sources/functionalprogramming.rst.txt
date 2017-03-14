The Functional Programming Paradigm
-----------------------------------

In this chapter, we study the functional programming paradigm, with examples and projects mostly in Scala.


Solving problems using built-in types and behaviors
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As do other languages, Scala provides an extensive library of predefined types and (generic) type constructors along with a rich set of behaviors.
Many of these, especially collection types and certain utility types, are *algebraic data types*, discussed below in more detail:

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

By using Scala like a scripting language (such as Python or Ruby), one can solve many problems without even defining custom algebraic data types, except perhaps the occasional tuple.
The main building blocks in scripting-style Scala are the collection and utility types we just mentioned, along with

- key methods ``map``, ``filter`` / ``withFilter``, ``find``, ``flatMap``, ``sum``, ``fold``, ``groupBy``, ``collect``
- ``for`` comprehensions


.. todo:: elaborate more on ``for`` comprehensions and ``flatMap``

  
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
  } takeWhile { line =>
    line != null
  } foreach { line =>
    processExpr(line)
  }


Note that we are using ``foreach`` when the body of the iteration produces a *side effect* such as output.
If we wanted to compute a *result value*, we could use ``foldLeft`` instead of ``foreach``.

Note also that all of these are methods but look like control structures because of Scala's syntax, which allows you to omit the dot in certain cases of method selection and to use curly braces instead of round parentheses to delimit your argument list.
  
The more familiar one becomes with the various predefined building blocks, the more quickly and productively one can put together at least an initial solution to a problem.
Earlier versions of the `process tree <https://github.com/lucproglangcourse/processtree-scala>`_ example illustrates this style, while later versions reflect greater emphasis on code quality, especially testability and avoidance of code duplication.


Challenges
``````````

Can we write (efficiently or not)

- ``length``, ``sum``, ``reverse``, ``filter``, ``find``, ``map`` as a fold, i.e., ``foldLeft`` or ``foldRight``? 
- ``foldLeft`` or ``foldRight`` as ``map``?!?
- ``reverse`` or ``filter`` as a ``map``?

Some hints:

- Look carefully at the respective domains and codomains (argument and result types). Can they fit?
- Which is more general, ``map`` or ``fold``?


Defining algebraic data types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Most structures fall into one of these categories:

- nonrecursive/scalars: boolean, finite enumerations (including numeric types), try
- sublinear structures: (infinite set of) natural numbers, option
- linear structures: lists, maps
- nonlinear structures: trees, graphs, many custom domain models

The fundamental building blocks of these *algebraic data types* are
related to those discussed in :ref:`secDomainModelsOO`:

- (disjoint) sum: variation
- product (tuple, record) of a given arity: aggregation
- recursion (at the type level)
- type parameters (genericity)

  
Using these building blocks, we can express the `Shape` domain model from the examples above as an algebraic data type::

        Shape = Circle(Int)
              | Rectangle(Int, Int)
              | Group(Seq(Shape))
              | Location(Int, Int, Shape)

We can separately define behaviors on Shapes as functions. Here is an example that illustrates this approach:

- https://github.com/lucproglangcourse/shapes-oo-scala 
- https://github.com/lucproglangcourse/expressions-scala 

We identify the following structural and behavioral concerns:

- structure
- content
- traversal
- processing

So far, structure and content are combined within the definition of an algebraic data type, while traversal and processing are combined within the definition of a behavior on that algebraic data type. 


Separation of structural concerns
`````````````````````````````````
  
We can, however, achieve a separation between structure and content with the help of *parametric polymorphism*, that is, making the algebraic data type *generic* in terms of the content.
The predefined collections are an example of this separation, as well as the `generic org chart <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchartGeneric.sc>`_ example.

  
Behaviors on algebraic data types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following are additional examples of behaviors on algebraic data types.
As expected, for recursive types, the behaviors are typically recursive as well.

- `simple org charts <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchart.sc>`_
- `generic org charts <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchartGeneric.sc>`_
- `simple natural numbers <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/nat.sc>`_
- `expressions-scala <https://github.com/lucproglangcourse/expressions-scala>`_

In these examples, the traversal and processing concerns identified above remain combined. 


Separation of behavioral concerns
`````````````````````````````````

A question that comes to mind is whether they can be separated, similarly to the predefined higher-order methods on collections, such as ``foldLeft``, ``foldRight``, ``map``, etc.
These methods go a step further than the Visitor pattern or our equivalent recursive behaviors:
They handle the *traversal* concern for us and separate it from the *processing* concern, which we handle by providing a suitable argument function.

- `functions on lists (reverse) <https://github.com/LoyolaChicagoCode/misc-explorations-scala/blob/master/functionsOnLists.sc>`_
- `functions on streams (potentially infinite lists with memoization) <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnStreams.sc>`_

This question has a two-part answer:  
Yes, we can define custom implementations of such higher-order behaviors for our own algebraic data types.
In addition, and this is where it gets really interesting, we can have a single, universal implementation that works for all algebraic data types where the children of any node are either fixed in number or stored in a collection that has a ``map`` method.  

Another, seemingly esoteric, question is whether we can pull out recursion itself as a functional pattern.
Yes, we can.
In `this factorial example <https://github.com/LoyolaChicagoCode/misc-explorations-scala/blob/master/factorial.sc>`_,
the ``Y``-combinator handles the *recursion* concern *for behaviors* and separates it from the concern of what should happen in each step of the recursion.

We will soon study the equivalent idea at the type level.


A closer look at predefined behaviors on lists
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this section, we take a look "under the hood" of some key predefined behaviors on lists.

In terms of performance, we must keep in mind that `lists are head/tail-optimized <http://www.scala-lang.org/api/current/scala/collection/immutable/List.html>`_.
In other words, these are basically singly-linked lists, so any behaviors where we access the first node of the list are constant-time, while behaviors involving nodes further down in the list are linear-time.
In practice, acceptable performance usually means linear time for behavior where we process the entire list.

In addition, we need to be aware of *space complexity*.
Clearly, we are already using space for the arguments we are about to pass to the behavior and are willing to dedicate space to the result we are getting back, so the focus is on *additional* temporary space on the stack, which we like to keep constant if possible.
(This discussion is closely related to :ref:`subsecConstantSpace`, where the assumption is that the arguments and the result are stored *externally*.)

*Tail recursion*, where the very last step in a method or function body is the recursive invocation of the method itself, is an effective technique for achieving constant-space complexity as long the behavior can be expressed in a tail-recursive way.
In some cases, we can rewrite an implementation in a tail-recursive way by introducing an *accumulator* argument, where we essentially build up the result in the accumulator and then return that result once we reach the base case of the recursion.
A tail-recursive implementation can easily be transformed to a ``while`` loop by introducing a mutable variable to represent the progress into the list structure.
This `reverse example <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnLists.sc>`_ illustrates these concepts and techniques in more detail.

Here are some observations:

- ``foldLeft`` is usually what we want: *linear-time* and *constant-space* (naturally tail-recursive).
- ``foldRight`` is *linear-time* and *linear-space* (*not* tail-recursive) but goes with the natural head-tail structure of the list. 
- `xs.foldRight(z)(f) == xs.reverse.foldLeft(z)(g)` where `g` is `f` with the arguments switched.

To look at the actual Scala library implementations of these functions, first find desired method in the API documentation, expand, look for *definition classes*, follow the link to the leftmost definition class, then the link to that class's Scala source, and finally look for the actual method.
For performance reasons, these professional implementations tend to appear more complex than we might expect.
Here are some examples:

- `foreach <https://github.com/scala/scala/blob/v2.12.1/src/library/scala/collection/immutable/List.scala#L375>`_
- `foldLeft <https://github.com/scala/scala/blob/v2.12.1/src/library/scala/collection/LinearSeqOptimized.scala#L118>`_
- `reverse <https://github.com/scala/scala/blob/v2.12.1/src/library/scala/collection/immutable/List.scala#L383>`_
- `foldRight <https://github.com/scala/scala/blob/v2.12.1/src/library/scala/collection/immutable/List.scala#L393>`_
- `map <https://github.com/scala/scala/blob/v2.12.1/src/library/scala/collection/immutable/List.scala#L269>`_
- `length <https://github.com/scala/scala/blob/v2.12.1/src/library/scala/collection/LinearSeqOptimized.scala#L47>`_

  
For more details on space complexity and tail recursion, please take a look at these references:

- `space complexity, tail recursion, and accumulators <http://blog.emielhollander.nl/tail-recursion-and-the-accumulator-in-scala/>`_
- `tail recursion, trampolines, and continuations <http://blog.richdougherty.com/2009/04/tail-calls-tailrec-and-trampolines.html>`_ (advanced)


      
Separation of concerns at the type level
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The overall approach is to formalize algebraic data types as initial F-algebras.


Key concepts
````````````

We first need to define some key concepts:

- `(Endo)functor <https://hseeberger.wordpress.com/2010/11/25/introduction-to-category-theory-in-scala>`_: a type constructor (generic collection) with a ``map`` method that satisfies *identity* and *composition* laws::

    c.map(identity) == c
    c.map(g compose f) == c.map(f).map(g)

    
- The ``Fix``-combinator handles the *recursion* concern *for structures* and separates it from the nature of the structure itself.
- Generalized ``fold`` = *catamorphism* (``cata``) for *breaking down* a data structure to a result value.
- `F-algebra <https://www.fpcomplete.com/user/bartosz/understanding-algebras>`_: This is the argument to ``fold``, which has a functor ``F`` and a carrier object, i.e., the result type of the fold.
- ``unfold`` = *anamorphism* for *building up* a data structure from some other value.
- *F-coalgebra*: This is the argument to ``unfold`` (generator), which also has a functor ``F`` and a carrier object, i.e., type of seed and generated values wrapped in the functor.
- *Initial F-algebra*: This is the least fixpoint of our functor ``F`` and equivalent to our original recursive type.
  We obtain this by applying the ``Fix``-combinator to ``F``.
- We get our original recursive behaviors back by combining ``cata`` and our specific F-algebraic version of the behavior.
  
.. todo:: Practical applications

	  
Examples
````````

It is perhaps best to look at some conventional and F-algebra-based examples side-by-side:

- `expressions-scala <https://github.com/lucproglangcourse/expressions-scala>`_ versus `expressions-algebraic-scala <https://github.com/lucproglangcourse/expressions-algebraic-scala>`_
-  `project 2a <https://trello.com/c/nPaqQAJf/58-project-2a>`_ versus `project 2b <https://trello.com/c/EihkYkGP/59-project-2b>`_


Key insights
````````````

By taking an F-algebraic perspective on recursive algebraic data types, we are able to recognize previously non-obvious structural commonalities among them.

- non-generic:  ``Nat``, ``Expr``, ``Shape``, etc.
- generic: ``List``, ``Tree``, ``OrgChart``, etc.

Still on the structural side, it also helps to study these questions:

- How are, say, ``Option``, ``List``, and ``Tree`` related? 
- How does

  - ``Option`` relate to ``List``
  - ``List`` relate to ``Tree``
  - ``Tree`` relate to ?!?
  - ...

On the behavioral side, we recognize the great potential for code reuse resulting from common abstractions:

- `Scalaz library <https://github.com/scalaz/scalaz>`_
- `Matryoshka library <https://github.com/slamdata/matryoshka>`_
- The various `Typelevel.scala projects <http://typelevel.org/projects>`_

For more details on F-algebras and datatype-generic programming, please take a look at these references:

- `Advanced Functional Programming with Scala <https://gist.github.com/jdegoes/97459c0045f373f4eaf126998d8f65dc>`_
- `Understanding F-Algebras <https://www.fpcomplete.com/user/bartosz/understanding-algebras>`_
- `Gibbons: origami programming <https://www.cs.ox.ac.uk/jeremy.gibbons/publications/origami.pdf>`_ (advanced)
- `Oliveira & Cook: F-algebras in Java <http://www.cs.utexas.edu/~wcook/Drafts/2012/ecoop2012.pdf>`_ (advanced)

If you want to dig a bit deeper, check out a generalization of ``map`` called `traverse <https://www.cs.ox.ac.uk/jeremy.gibbons/publications/iterator.pdf>`_.
Some of our examples include implementations of ``traverse``.


Other useful abstractions
~~~~~~~~~~~~~~~~~~~~~~~~~

In this subsection, we will discuss a few more useful yet relatively simple abstractions.


Monoid
``````

A `Monoid <https://en.wikipedia.org/wiki/Monoid_(disambiguation)>`_ is a type with an associative binary operation and an identity element.
(This is equivalent to a semigroup with an identity element.)
Examples include:

- integers with addition and zero
- integers with multiplication one
- lists with append and the empty list
- strings with concatenation and the empty string

The *monoid laws* arise from the monoid's definition: the operation must be associative, and the identity element must be a left and right identity.

Examples of monoids using the Scalaz library are available here:
  
- https://github.com/lucproglangcourse/scalaz-explorations-scala/monoid.sc


Monad
`````

A `Monad <https://en.wikipedia.org/wiki/Monad_(functional_programming)>`_ is a type constructor (generic collection) with two operations, ``point`` (also called ``return`` or ``unit``) and ``flatMap`` (also called ``bind``).
Monads are an effective way to represent the *context* of a computation in which the computation is "wrapped".
The monad abstraction thereby enables one to separate the concerns of the computation itself and its context.
Examples include:

- ``Option`` and ``Try``: potential failure in a computation
- ``List``: nondeterminism in a computation, meaning that the computation might have multiple results
- ``Id``: the identity monad, a wrapper that doesn't actually do anything
- ``Future``: the computation takes place asynchronously (in the background)

Examples of monads using the Scalaz library are available here:
  
- https://github.com/lucproglangcourse/scalaz-explorations-scala/monad.sc


Observations
````````````
    
- The Scala library includes various structures that are effectively monads, especially those just mentioned.
  What Scala does not define is a monad abstraction itself.
- This is where libraries like Scalaz or Cats come in:
  They define these abstractions in such a way that we can retrofit existing types or our own types to become instances of the desired abstractions, using the *Typeclass pattern*, a technique for representing Haskell-style typeclasses.
- Examples of the Typeclass pattern are the ``Functor`` and ``Traverse`` instances in our expressions and shapes examples.
- A good reference for learning Scalaz, a library that defines these various abstractions, is available `here <http://eed3si9n.com/learning-scalaz>`_.


References 
~~~~~~~~~~

.. todo:: put chapter-level references here
