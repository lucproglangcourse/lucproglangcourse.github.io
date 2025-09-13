The Functional Programming Paradigm
-----------------------------------

In this chapter, we study the functional programming paradigm, with examples and projects mostly in Scala.


Core Elements
~~~~~~~~~~~~~~~~~~

The functional paradigm is characterized by **computation as the evaluation of functions**.  
Functions are *first-class citizens*, programs are expressed declaratively, and emphasis 
is placed on immutability and avoidance of side effects.


Expression-Oriented Computation
````````````````````````````````

- Programs are built from expressions that yield values.
- No distinction between statements and expressions in purely functional languages.

Immutability
````````````````````

- Variables are bound once and cannot be reassigned.
- Encourages referential transparency: expressions can be replaced with their values without changing program meaning.

First-Class and Higher-Order Functions
``````````````````````````````````````

- **Functions as first-class values**: can be passed as arguments, returned as results, and stored in data structures.
- **Higher-order functions**: functions that take other functions as parameters or return them.


Recursion
``````````````

- Primary mechanism for repetition.
- Loops are replaced by recursive definitions.

Pattern Matching
`````````````````

- Provides a declarative way to deconstruct data structures and control flow.
- Enables concise handling of algebraic data types.

Lazy Evaluation
````````````````

- Expressions evaluated only when needed (default in Haskell).
- Can improve modularity and performance.

Other Elements
``````````````

- **Closures**: functions that capture their lexical environment.
- **Type inference**: deduce function and variable types automatically (e.g., Haskell, Scala).
- **Purity**: avoiding side effects; I/O and state modeled explicitly (monads, uniqueness types).


Examples Across Languages
```````````````````````````

.. list-table::
   :header-rows: 1
   :widths: 20 20 20 20 20

   * - Element
     - Java
     - Scala
     - Haskell
     - Scheme
   * - First-class function
     - ``Function<Integer,Integer> f = x -> x+1;``
     - ``val f = (x:Int) => x+1``
     - ``f x = x+1``
     - ``(define f (lambda (x) (+ x 1)))``
   * - Higher-order function
     - ``list.stream().map(x -> x+1)``
     - ``List(1,2,3).map(_+1)``
     - ``map (+1) [1,2,3]``
     - ``(map (lambda (x) (+ x 1)) '(1 2 3))``
   * - Immutability
     - ``final var y = 5;``
     - ``val y = 5``
     - ``let y = 5 in ...``
     - ``(define y 5)`` (by convention immutable)
   * - Recursion
     - ``int fact(int n){ return n==0?1:n*fact(n-1); }``
     - ``def fact(n:Int):Int = if (n==0) 1 else n*fact(n-1)``
     - ``fact 0 = 1; fact n = n*fact(n-1)``
     - ``(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))``
   * - Pattern matching
     - Not built-in
     - ``x match { case 0 => 1; case n => n*fact(n-1) }``
     - ``fact 0 = 1; fact n = n*fact (n-1)``
     - Not built-in (simulate with cond)
   * - Lazy evaluation
     - Streams (``Stream.of(1,2,3)``)
     - ``LazyList.from(1)``
     - Default in Haskell
     - Not default; can simulate with thunks
   * - Closure
     - ``Function<Integer,Integer> f = (x) -> x + y;``
     - ``val f = (x:Int) => x + y``
     - ``f = \x -> x + y``
     - ``(define f (lambda (x) (+ x y)))``


Discussion
````````````

Functional programming emphasizes *declarative expression of computation* 
rather than step-by-step instructions.  
It enables equational reasoning, parallelization, and safer abstractions by 
reducing reliance on mutable state.  

Modern multiparadigm languages (Scala, Python, Java 8+) integrate functional 
features, while classic functional languages like Scheme, Haskell, and ML 
highlight the paradigm in its purest form.


Solving problems using built-in types and behaviors
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this section, we'll first return to the scripting style for a bit but with a functional touch, which encourages the use of immutable references and data structures.
Arguably, this makes it easier to understand program behavior, especially in the presence of concurrency, defined as more than one activity (task, thread, or process) going on at the same time.

As do other languages, Scala provides an extensive library of predefined types and (generic) type constructors along with a rich set of behaviors.
Many of these, especially collection types and certain utility types, are *algebraic data types*, discussed below in more detail:

- ``Seq`` / ``List``

  - https://www.scala-lang.org/api/current/scala/collection/Seq.html
  - https://www.scala-lang.org/api/current/scala/collection/immutable/List.html
  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/lists.sc
  - note the difference between those and tuples

- ``Map``

  - https://www.scala-lang.org/api/current/scala/collection/Map.html

- ``Option`` / ``Either``

  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/option.sc
  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/either.sc
  - http://robsscala.blogspot.com/2012/06/fixing-scalaeither-unbiased-vs-biased.html

- ``Try``

  - https://www.scala-lang.org/api/current/scala/util/Try.html
  - https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/try.sc

By using Scala like a scripting language (such as Python or Ruby), one can solve many problems without even defining custom algebraic data types, except perhaps the occasional tuple, a lightweight aggregation of heterogeneous types based on the Cartesian product.
The main building blocks in scripting-style Scala are the collection and utility types we just mentioned, along with these behaviors:

- important methods ``map``, ``take`` / ``drop``, ``filter`` / ``withFilter``, ``find``, ``flatMap``, ``sum``, ``foldLeft`` / ``foldRight``, ``scanLeft``, ``zip``, ``groupBy``, ``collect``
- ``for`` comprehensions


.. todo:: Elaborate more on ``for`` comprehensions and ``flatMap``


Examples
````````

Loop over all items in a finite collection or iterator using mutable state:

.. code-block:: java

  final Iterator<String> incoming = ...;
  var sum = 0;
  var count = 0;
  incoming.forEachRemaining(s -> {
    sum += s.length();
    count += 1;
  });
  final var result = (float) sum / count;

*What does this code compute?*


Immutable equivalent using ``foldLeft``:

.. code-block:: scala

  val (sum, count) = incoming.foldLeft {
    (0, 0)
  } { case ((sum, count), next) =>
    (sum + next.length, count + 1)
  }
  val result = sum.toFloat / count

Note that you cannot "un-fuse" this loop equivalent because the iterator is stateful and you can iterate through it only once.
On the other hand, if ``incoming`` is a collection (always finite) instead of an iterator (potentially unbounded), you can use ``map`` and ``sum``, a specialized fold, for a terser equivalent:

.. code-block:: scala

  val sum = incoming.map(s => s.length).sum
  val count = incoming.size
  val result = sum.toFloat / count

This is equivalent to two consecutive loops, one for ``map`` and one for ``sum``.

Unbounded loop until a condition is met:

.. code-block:: java

  final var input = new Scanner(System.in);
  System.out.print("enter next expression: ");
  while (input.hasNextLine()) {
    final var line = input.nextLine();
    processExpr(line)
    System.out.print("enter next expression: ");
  }

Immutable equivalent using ``continually``:

.. code-block:: scala

  Iterator continually {
    print("enter next expression: ")
    StdIn.readLine()
  } takeWhile { line =>
    line != null
  } foreach { line =>
    processExpr(line)
  }


Other important operations on collections
`````````````````````````````````````````

- When the body of the iteration produces a *side effect* such as output, we can use ``foreach`` instead of ``continually``.
- If we want to compute a *result value*, we can use ``foldLeft`` instead of ``foreach``.
- If we want to compute a *sequence of result values*, one for each original item, we can use ``scanLeft`` (examples are available `here <https://github.com/lucproglangcourse/iterators-scala>`_).
- If we want to transform a *collection of result values* by independently applying the same function to each item while preserving the collection's skeletal structure, we can use ``map``.
- If we want to do the same as ``map`` but without introducing an additional level of structural nesting even though the function does so, we can use ``flatMap``, which flattens the inner structure into the outer; an example is the splitting of lines to words seen in the section on console applications. ``flatMap`` is equivalent to ``map`` followed by ``flatten``.

The following example illustrates the difference between ``map`` and ``flatMap`` from an imperative perspective:

.. code-block:: scala

   // map - the result is a nested collection

   scala> Seq("hello world what up", "hola mundo", "hallo welt")
   res0: Seq[String] = List(hello world what up, hola mundo, hallo welt)

   scala> res0.map(s => s.split("\\s+"))
   val res1: Seq[Array[String]] = List(Array(hello, world, what, up), Array(hola, mundo), Array(hallo, welt))

   scala> val resultNested = scala.collection.mutable.ArrayBuffer.empty[Array[String]]
   resultNested: scala.collection.mutable.ArrayBuffer[Array[String]] = ArrayBuffer()

   scala> res0.foreach { line =>
	|   val words = line.split("\\s+")
	|   resultNested += words
	| }

   scala> resultNested
   res2: scala.collection.mutable.ArrayBuffer[Array[String]] = ArrayBuffer(Array(hello, world, what, up), Array(hola, mundo), Array(hallo, welt))

   // flatMap - the result is a flat collection - this requires nested loops!

   scala> res0.flatMap(s => s.split("\\s+"))
   val res3: Seq[String] = List(hello, world, what, up, hola, mundo, hallo, welt)

   scala> val resultFlat = scala.collection.mutable.ArrayBuffer.empty[String]
   resultFlat: scala.collection.mutable.ArrayBuffer[String] = ArrayBuffer()

   scala> res0.foreach { line =>
	|   val words = line.split("\\s+")
	|   words.foreach { word =>
	|     resultFlat += word
	|   }
	| }

   scala> resultFlat
   res4: scala.collection.mutable.ArrayBuffer[String] = ArrayBuffer(hello, world, what, up, hola, mundo, hallo, welt)


Note also that all of these are methods but look like control structures because of Scala's syntax, which allows you to omit the dot in certain cases of method selection and to use curly braces instead of round parentheses to delimit your argument list.


Dealing with successive failures
````````````````````````````````

Trying successive choices until either one succeeds or there is none left and we have to give up.
Nested ``try``-``catch`` statements are often used to achieve this:

.. code-block:: java

  AuthorizeRequestStrategy authorizeRequest = null;
  try {
    logger.debug("looking for access token");
    ...
    logger.debug("found access token");
    authorizeRequest = (request) -> request.addHttpHeaders(authHeader);
  } catch (final FileNotFoundException ex) {
    try {
      logger.debug("looking for API key in environment");
      final var apiKey = sys.env("API_KEY");
      logger.debug("found API key");
      authorizeRequest = (request) -> request.addQueryStringParameter("key", apiKey);
    } catch (final NoSuchElementException ex) {
      logger.debug("no authorization information found, exiting");
      System.exit(401);
    }
  }

Immutable equivalent using successive ``Try`` blocks, flat-chained using ``orElse``:

.. code-block:: scala

   val authorizeRequest = Try {
      logger.debug("looking for access token in property file")
      ...
      logger.debug("found access token")
      val authHeader = KeyAuthorization -> s"Bearer $accessToken"
      (request: WSRequest) => request.addHttpHeaders(authHeader)
    } orElse Try {
      logger.debug("looking for API key in environment")
      val apiKey = sys.env("API_KEY")
      logger.debug("found API key")
      (request: WSRequest) => request.addQueryStringParameters("key" -> apiKey)
    } getOrElse {
      logger.debug("no authorization information found, exiting")
      sys.exit(401)
    }


The more familiar one becomes with the various predefined building blocks, the more quickly and productively one can put together at least an initial solution to a problem.
Earlier versions of the `process tree <https://github.com/lucproglangcourse/processtree-scala>`_ example illustrates this style, while later versions reflect greater emphasis on code quality, especially testability and avoidance of code duplication.

.. todo:: ``for`` with blocks for embedding stateful steps such as logging


Challenges
``````````

Can we write (efficiently or not)

- ``length``, ``sum``, ``reverse``, ``filter``, ``find``, ``map`` as a fold, i.e., ``foldLeft`` or ``foldRight``?
- ``foldLeft`` or ``foldRight`` as ``map``?!?
- ``reverse`` or ``filter`` as a ``map``?

Some hints:

- Look carefully at the respective domains and codomains (argument and result types). Can they fit?
- Which is more general, ``map`` or ``fold``?



Modularity and dependency injection in the functional style
```````````````````````````````````````````````````````````

In the functional programming paradigm, first-class functions, i.e., the ability to pass functions as argument values to other functions, methods, and constructors, provides an alternative modular composition mechanism to the object-oriented ones discussed previously.

The `iterators example <https://github.com/lucproglangcourse/iterators-scala>`_ illustrates functional modularity in its ``functional/modular`` package.


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


Using these building blocks, we can express the `Shape` domain model from the examples above as an algebraic data type:

.. code-block:: haskell

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
- `shapes-oo-scala <https://github.com/lucproglangcourse/shapes-oo-scala>`_

In these examples, the traversal and processing concerns identified above remain combined.


Behaviors based on recursive thinking
`````````````````````````````````````

To understand recursive thinking, let us explore the familiar `shapes example <https://github.com/lucproglangcourse/shapes-oo-scala>`_.
We'll start with a suitable algebraic type definition and some sample instances:

.. code-block:: scala

    enum Shape:
      case Rectangle(width: Int, height: Int)
      // ...
      case Location(x: Int, y: Int, shape: Shape)
      case Group(shapes: Shape*)

    val r = Rectangle(20, 40)
    val q = Rectangle(20, 40)
    val p = Rectangle(20, 30)

    val g = Group(r, Group(q, p), Location(10, 15, r))


Let's now try to implement a ``countGroup`` behavior.
This is incomplete but should compile;
``???`` is a convenient placeholder for "not yet implemented" (NYI).

.. code-block:: scala

    def countGroup(s: Shape): Int = s match
      case Rectangle(w, h) => 0
      case Location(x, y, c) => ???
      case Group(shapes*) => ???

As expected, ``countGroup`` returns 0 for rectangles but would raise a ``NYI`` exception for group or location nodes.

Now we need to apply recursive thinking:

- For location, the child might have group nodes.
- For group, the current node is a group node, plus the children might have group nodes.

Accordingly:

.. code-block:: scala

    def countGroup(s: Shape): Int = s match
      case Rectangle(w, h) => 0
      case Location(x, y, c) => countGroup(c)
      case Group(shapes*) =>
        var sum = 1
        for c <- shapes do
          sum += countGroup(c)
        sum

Now ``countGroup(g)`` returns 2 as expected, though this is a Java-style, imperative implementation.
Equivalently, we can use the ``foreach`` method instead of the so-called for comprehension:

.. code-block:: scala

    case Group(shapes*) =>
      var sum = 1
      shapes.foreach { c =>
        sum += countGroup(c)
      }
      sum

Now...drum roll...we have an opportunity to convert this code into functional, applicative, immutable style:

.. code-block:: scala

    case Group(shapes*) =>
      1 + shapes.map { c => countGroup(c) } .sum

where map transforms each item in a collection with the result of applying the given function to the item and sum adds all the items in a collection.

Some points to think about:

- Which design pattern describes the function we pass to the ``map`` method?
- How would you compare these three implementations in terms of whatever functional and/or nonfunctional criteria you can think of?


Separation of behavioral concerns
`````````````````````````````````

A question that comes to mind is whether they can be separated, similarly to the predefined higher-order methods on collections, such as ``foldLeft``, ``foldRight``, ``map``, etc.
These methods go a step further than the Visitor pattern or our equivalent recursive behaviors:
They handle the *traversal* concern for us and separate it from the *processing* concern, which we handle by providing a suitable argument function.

- `functions on lists (reverse) <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnLists.sc>`_
- `functions on streams (potentially infinite lists with memoization) <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/functionsOnStreams.sc>`_

This question has a two-part answer:
Yes, we can define custom implementations of such higher-order behaviors for our own algebraic data types.
In addition, and this is where it gets really interesting, we can have a single, universal implementation that works for all algebraic data types where the children of any node are either fixed in number or stored in a collection that has a ``map`` method.

Another, seemingly esoteric, question is whether we can pull out recursion itself as a functional pattern.
Yes, we can.
In `this factorial example <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/factorial.sc>`_,
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
- ``xs.foldRight(z)(f) == xs.reverse.foldLeft(z)(g)`` where ``g`` is ``f`` with the arguments switched.

To look at the actual Scala library implementations of these functions, first find desired method in the API documentation, expand, look for *definition classes*, follow the link to the leftmost definition class, then the link to that class's Scala source, and finally look for the actual method.
For performance reasons, these professional implementations tend to appear more complex than we might expect.
Here are some examples:

- `foreach <https://github.com/scala/scala/blob/v2.12.4/src/library/scala/collection/immutable/List.scala#L375>`_
- `foldLeft <https://github.com/scala/scala/blob/v2.12.4/src/library/scala/collection/LinearSeqOptimized.scala#L118>`_
- `reverse <https://github.com/scala/scala/blob/v2.12.4/src/library/scala/collection/immutable/List.scala#L383>`_
- `foldRight <https://github.com/scala/scala/blob/v2.12.4/src/library/scala/collection/immutable/List.scala#L393>`_
- `map <https://github.com/scala/scala/blob/v2.12.4/src/library/scala/collection/immutable/List.scala#L269>`_
- `length <https://github.com/scala/scala/blob/v2.12.4/src/library/scala/collection/LinearSeqOptimized.scala#L47>`_


For more details on space complexity and tail recursion, please take a look at these references:

- `Tail Recursion in Scala <https://kartikiyer.com/2020/08/04/tail-recursion-in-scala>`_
- `Functional Programming Recursion Styles, Correctness, and Efficiency <https://john.cs.olemiss.edu/~hcc/csci555/notes/RecursionStyles/RecursionStylesScala.html>`_
- `tail recursion, trampolines, and continuations <http://blog.richdougherty.com/2009/04/tail-calls-tailrec-and-trampolines.html>`_ (advanced)



Separation of concerns at the type level
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: This section is aimed at primarily at graduate students, but advanced undergradutes are encouraged to work through it as well.

The overall approach is to separate recursion from structure by formalizing algebraic data types as initial F-algebras.


Key concepts
````````````

We first need to define some key concepts:

- `(Endo)functor <https://hseeberger.wordpress.com/2010/11/25/introduction-to-category-theory-in-scala>`_: a type constructor (generic collection) with a ``map`` method that satisfies *identity* and *composition* laws:

  .. code-block:: scala

    c.map(identity) == c
    c.map(g compose f) == c.map(f).map(g)

  Some familiar examples of endofunctors are

  - ``Option``
  - ``List``
  - generic trees such as `org chart <https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchartGeneric.sc>`_

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
-  Project 1a (shapes) versus Project 1b (shapes redone using F-algebras) on Sakai

Some other examples are available `here <https://github.com/lucproglangcourse/droste-explorations-scala/>`_.


What ``Fix`` does
`````````````````

``Fix[F]`` basically ties the "recursive knot" by applying the functor ``F``  to itself.
This forms the *fixpoint* of the functor, allowing all structures built from the functor to have the same type, as opposed to nested types corresponding to the nesting of the structure.

For instance, we can represent the familiar aggregation of an item and an (optional) next node using the functor ``F[A] = (Int, Option[A])``.
This enables  us to define linked lists:

.. code-block:: scala

  (1, Some((2, Some((3, None)))))

The problem is that the types of these lists are nested:

.. code-block:: scala

  scala> (1, Some((2, Some((3, None)))))
  res0: (Int, Some[(Int, Some[(Int, None.type)])]) = (1,Some((2,Some((3,None)))))


so that lists of different lengths have different types.

By using a suitable ``Fix`` over our functor, they all end up having the *same* type, namely ``Fix``:

.. code-block:: scala

  case class Fix(unFix: (Int, Option[Fix]))

  scala> Fix((1, Some(Fix((2, Some(Fix((3, None))))))))
  res1: Fix = Fix((1,Some(Fix((2,Some(Fix((3,None))))))))


That's why we usually define such types recursively to begin with.


Generalized fold (catamorphism)
```````````````````````````````

The next question is what the implementation of the universal fold method for ``Fix`` looks like, also known as the *catamorphism*.
Continuing with our ``Fix`` over ``(Int, Option[A])`` example, we perform recursion over this functor by using ``map``, which preserves the first component and invokes a suitable ``map`` on the second component of the pair:

.. code-block:: scala

  case class Fix(unFix: (Int, Option[Fix])):
    def cata[B](f: ((Int, Option[B])) => B): B = f((this.unFix._1, this.unFix._2.map(_.cata(f))))

Now we can define *algebras* on our functor, such as:

.. code-block:: scala

  def sum(arg: (Int, Option[Int])): Int = arg match
    case (i, None) => i
    case (i, Some(s)) => i + s

  res1.cata(sum) // 6

These are very similar to visitors without the responsibility to traverse the structure.
That is why they are not recursive.
Instead, the catamorphism takes care of the recursion.

For an arbitrary functor ``F``, the code looks like this:

.. code-block:: scala

  case class Fix(unFix: F[Fix]):
    def cata[B](f: F[B] => B): B = f(this.unFix.map(_.cata(f)))


For an arbitrary *carrier type* ``B``, the argument ``f`` of type ``F[B] => B`` is an ``F``-algebra.
``Fix[F]`` is the *initial* ``F``-algebra, and the catamorphism ``cata`` produces the unique structure-preserving mapping (homomorphism) between ``Fix[F]`` and ``f``.


Key insights
````````````

By taking an F-algebraic perspective on recursive algebraic data types, we are able to recognize previously non-obvious structural commonalities among them.

- non-generic:  ``Nat``, ``Expr``, ``Shape``, etc.
- generic: ``List``, ``Tree``, ``OrgChart``, etc.

It also helps to study these questions:

- How are, say, ``Option``, ``List``, and ``Tree`` related?
- How does

  - ``Option`` relate to ``List``
  - ``List`` relate to ``Tree``
  - ``Tree`` relate to ?!?
  - ...

- How do we represent an *empty* structure?
- Why aren't there multiple branches in the definition of ``cata`` above?
  When does the recursion terminate?
- Is ``cata`` tail-recursive? Can or should it be?


On the behavioral side, we recognize the great potential for code reuse resulting from common abstractions:

- `Cats library of high-level abstractions <https://typelevel.org/cats>`_
- `Droste library of recursion schemes <https://github.com/higherkindness/droste>`_
-  Various other `Typelevel.scala projects <http://typelevel.org/projects>`_

For more details on F-algebras and datatype-generic programming, please take a look at these references:

- `Advanced Functional Programming with Scala <https://gist.github.com/jdegoes/97459c0045f373f4eaf126998d8f65dc>`_
- `Understanding F-Algebras <https://www.fpcomplete.com/user/bartosz/understanding-algebras>`_
- `Gibbons: origami programming <https://www.cs.ox.ac.uk/jeremy.gibbons/publications/origami.pdf>`_ (advanced)
- `Oliveira & Cook: F-algebras in Java <http://www.cs.utexas.edu/~wcook/Drafts/2012/ecoop2012.pdf>`_ (advanced)
- `Joe Warren's four ways to make change in Scala <http://www.doscienceto.it/blog/posts/2020-09-16-change.html>`_
- `Patrick Thomson's blog post series on recursion schemes <https://blog.sumtypeofway.com/archive.html>`_

If you want to dig a bit deeper, check out a generalization of ``map`` called `traverse <https://www.cs.ox.ac.uk/jeremy.gibbons/publications/iterator.pdf>`_.
Some of our examples include implementations of ``traverse``.


Other useful abstractions
~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: This section is aimed at primarily at graduate students, but advanced undergradutes are encouraged to work through it as well.

In this section, we will discuss a few more useful yet relatively simple abstractions.


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

Examples of monoids using the Scalaz library are available `here <https://github.com/lucproglangcourse/scalaz-explorations-scala/tree/master/monoid.sc>`_


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

Examples of monads using the Scalaz library are available `here <https://github.com/lucproglangcourse/scalaz-explorations-scala/tree/master/monad.sc>`_.


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
