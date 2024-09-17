The Imperative and Object-Oriented Paradigms in Scala
-----------------------------------------------------

In this chapter, we discuss the imperative and object-oriented programming paradigms with examples in Scala.

Options for running Scala code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this section, we discuss the different options for running Scala code, including applications and tests.

- The simplest way to run Scala code fragments is through the Scala REPL (read-eval-print loop).
  We can launch the Scala REPL and then evaluate definitions and expressions:

  .. code-block:: scala

    $ scala
    Welcome to Scala 3.2.0 (17.0.4.1, Java OpenJDK 64-Bit Server VM).
    Type in expressions for evaluation. Or try :help.

    scala> 3 + 4
    res0: Int = 7

    scala> def f(x: Int) = x + 2
    f: (x: Int)Int

    scala> f(3)
    res1: Int = 5

    scala> val z = f(4)
    z: Int = 6

    scala> Seq(1, 2, 3).map(f)
    res2: Seq[Int] = List(3, 4, 5)


  This is a very effective, painless way to conduct initial explorations.
  The drawback of this approach is a lack of support for *managed dependencies*, which are required for more advanced work.
  In that case, starting the Scala REPL through sbt as discussed below is a much better choice.
  Managing the Scala/Java classpath manually is discouraged.

  You can also run simple scripts (with optional command-line arguments) directly through the scala interpreter. A ``main`` method or ``@main`` annotation is required, e.g.:

  .. code-block:: bash

    $ cat > blah.scala
    def main(args: Array[String]) = println(args.toList)
    $ scala blah.scala 1 2 3
    List(1, 2, 3)


- In a Scala IDE such as IntelliJ IDEA, we can run Scala applications (classes/objects with a ``main`` method) and Scala tests from within the IDE. To pass command-line arguments to an application, we have to create a suitable run configuration.

- It is best to use `sbt <https://www.scala-sbt.org/>`_ (the Scala Build Tool) for projects with one or more external dependencies because of sbt's (and similar build tools') ability to manage these dependencies in a declarative way:

  .. code-block:: bash

    $ sbt test
    $ sbt run
    $ sbt "run arg1 arg2 ..."
    $ sbt "runMain my.pkg.Main arg1 arg2 ..."
    $ sbt test:run


  In addition, sbt allows you to start a REPL that exposes the code in your project and its managed dependencies.
  This is the preferred way to explore existing libraries:

  .. code-block:: bash

    $ sbt console


  You can also pull in the additional dependencies from the test scope:

  .. code-block:: bash

    $ sbt test:console

  If you want to bypass your own code in case of, say, compile-time errors, you can use one of these tasks:

  .. code-block:: bash

    $ sbt consoleQuick
    $ sbt test:consoleQuick

  In conjunction with a `text editor <https://www.gnu.org/software/emacs>`_, sbt's `triggered execution <https://www.scala-sbt.org/1.x/docs/Triggered-Execution.html>`_ for testing will significantly shorten the edit-compile-run/test cycle, for example:

  .. code-block:: bash

    $ sbt
    ...
    > ~ test


- In general, irrespective of your choice of development environment, a convenient way to do exploratory programming beyond the basic REPL is to start with a single test.
  There, you can develop your ideas and interact with the library APIs you want to explore.
  For simple testing, you can intersperse assertions within your code or use the testing support provided by the chosen testing framework, e.g., `JUnit <https://junit.org/>`_ or `ScalaTest <https://www.scalatest.org/>`_.
  So you can start exploring something in a test and then move it into your production code (`main` folder) when appropriate.
  `The list performance example <https://github.com/lucproglangcourse/cs2-listperformance-scala/blob/main/src/test/scala/cs271/lab/list/TestList.scala>`_ illustrates this approach.


- Finally, to turn an sbt-based Scala application into a script (console application) you can run outside sbt, you can use the `sbt-native-packager <https://github.com/sbt/sbt-native-packager>`_ plugin.
  To use this plugin, add this line to the end of ``build.sbt``:

  .. code-block:: bash

    enablePlugins(JavaAppPackaging)

  and this one to ``project/plugins.sbt``:

  .. code-block:: scala

    addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.7.5")

  Then, after any change to your sources, you can create/update the script and run it from the command line like so:

  .. code-block:: bash

    $ sbt stage
    ...
    $ ./target/universal/stage/bin/myapp-scala arg1 arg2 ...


Choices for testing Scala code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Testing is an important, widely used practice within the software development lifecycle (SDLC).
There are various basic techniques and libraries/frameworks for testing Scala code.

The simplest way is to intersperse assertions within your code.
This is particularly effective for scripts and worksheets:

.. code-block:: scala

  val l = List(1, 2, 3)
  assert { l.contains(2) }

The following testing libraries/frameworks work well with Scala.

- The familiar `JUnit <http://junit.org>`_ can be used directly.
- `ScalaCheck <http://scalacheck.org>`_ is a testing framework for Scala that emphasizes property-based testing, including universally quantified properties, such as "for all lists ``x`` and ``y``, the value of ``(x ++ y).length`` is equal to ``x.length + y.length``"
- `ScalaTest <http://scalatest.org>`_ is a testing framework for Scala that supports a broad range of test styles including behavior-driven design, including integration with ScalaCheck.
- `specs2 <http://etorreborre.github.io/specs2>`_ is a specification-based testing library that also supports integration with ScalaCheck.
- `MUnit <https://github.com/scalameta/munit>`_ is a newer testing library for Scala.

The `echotest <https://github.com/lucproglangcourse/echotest-scala>`_ example shows some of these libraries in action.

For faster turnaround during development, we can combine these techniques with `triggered execution <https://www.scala-sbt.org/1.x/docs/Triggered-Execution.html>`_.



The role of console applications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Console applications have always been an important part of the UNIX command-line environment.
The typical console application interacts with its environment in the following ways:

- zero or more application-specific *command-line arguments* for passing options to the application: ``app arg1 arg2 ...``
- *standard input* (stdin) for reading the input data
- *standard output* (stdout) for writing the output data
- *standard error* (stderr) for displaying error messages separately from the output data

Applications written in this way can function as composable building blocks using UNIX pipes.
Using these standard I/O mechanisms is much more flexible than reading from or writing to files whose names are hardcoded in the program.

E.g., the ``yes`` command outputs its arguments forever on consecutive output lines,
the ``head`` command outputs a finite prefix of its input,
and the ``wc`` command counts the number of characters, words, or lines:

.. code-block:: bash

  $ yes hello | head -n 10 | wc -l

You may wonder how the upstream (left) stages in the pipeline know when to terminate.
Concretely, how does the ``yes`` command know to terminate after ``head`` reads the first ten lines.
When ``head`` is done after reading and passing through the specified number of lines, it closes its input stream, and ``yes`` will receive an error signal called ``SIGPIPE`` when it tries to write further data to that stream.
The default response to this error signal is termination.
For more details on ``SIGPIPE``, see `this StackExchange response <https://unix.stackexchange.com/a/84828>`_.

We can also use the control structures built into the shell. E.g., the following loop prints an infinite sequence of consecutive integers starting from 0:

.. code-block:: bash

  $ n=0 ; while :; do echo $n ; ((n=n+1)) ; done

These techniques are useful for producing test data for our own applications.
To this end, we can redirect output to a newly created file using this syntax:

.. code-block:: bash

  $ n=0 ; while :; do echo $n ; ((n=n+1)) ; done > testdata.txt

If ``testdata.txt`` already exists, it will be overwritten when using this syntax.
We can also append to an existing file:

.. code-block:: bash

  $ ... >> testdata.txt

Similarly, we can redirect input from a file using this notation:

.. code-block:: bash

  $ wc -l < testdata.txt

There is a close relationship between UNIX pipes and functional programming: When viewing a console application as a function that transforms its input to its output, UNIX pipes correspond to function composition. The pipeline ``p | q`` corresponds to the function composition ``q o p``.


Console applications in Scala
`````````````````````````````

The following techniques are useful for creating console applications in Scala.
As in Java, command-line arguments are available to a Scala application as ``args`` of type ``Array[String]``.

We can read the standard input as lines using this iterator:

.. code-block:: scala

  val lines = scala.io.Source.stdin.getLines()

This gives you an iterator of strings with each item representing one line. When the iterator has no more items, you are done reading all the input. (See also this `concise reference <https://alvinalexander.com/scala/how-to-open-read-text-files-in-scala-cookbook-examples>`_.)

To break the standard input down further into words, we can use this recipe:

.. code-block:: scala

  val words =
    import scala.language.unsafeNulls
    lines.flatMap(l => l.split("(?U)[^\\p{Alpha}0-9']+"))

The result of ``l.split(regex)`` is an array of strings, where some of the strings or the entire array could possibly be ``null``. 
While ``flatMap`` is supposed to preserve the element type of the transformed iterator, splitting the lines in this way could introduce ``null`` references.
Because we require explicit typing of null references (by adding ``"-Yexplicit-nulls"`` to the compiler options in ``build.sbt``), the Scala compiler considers this code incorrect and indicates an error unless we enable this potentially unsafe use of implicit null references.

*To keep null safety in place as widely as possible, it is best to keep this import local to the block performing IO code.*
    
By default, the Java virtual machine converts the ``SIGPIPE`` error signal to an ``IOException``.
In Scala, ``print`` and ``println`` print to stdout, which is is an instance of ``PrintStream``.
This class converts any ``IOException`` to a boolean flag accessible through its ``checkError()`` method.
(See also `this discussion <https://stackoverflow.com/questions/62658078/jvm-not-killed-on-sigpipe>`_ for more details.)

Therefore, to use a Scala (or Java) console application in a UNIX pipeline as an upstream component that produces an unbounded (potentially infinite) output sequence, we have to monitor this flag when printing to stdout and, if necessary, terminate execution.

For example, this program reads one line at a time and prints the line count along with the line read.
After printing, it checks whether an error occured and, if necessary, terminates execution by exiting the program:

.. code-block:: scala

  var count = 0
  for line <- lines do
    count += 1
    println((count, line))
    if scala.sys.process.stdout.checkError() then sys.exit(1)


Command-line argument parsing
`````````````````````````````

A common concern when developing console applications is command-line argument and option parsing.
As briefly mentioned above, arguments and options are application-specific settings we can pass an application in the form ``app arg1 arg2 ...`` at the time when we're invoking the application.
Importantly, these settings are separate from the application's input data.

E.g., in our `sliding queue example <https://github.com/lucproglangcourse/consoleapp-java>`_, we keep a sliding queue of the n most recent words read from the input;
therefore, when invoking this application, we need to choose a specific value for n.
This is something we would typically use command-line arguments for.

Since the C language days, applications have received their command-line arguments as an array of strings; 
this is still the case in the Java/Scala world, where the main entry point receives the command-line arguments as a string array.
We can examine these arguments programmatically, make sure there are the correct number of them, convert them to numbers as needed, etc.

.. code-block:: java

  // perform argument validity checking
  if (args.length > 1) {
    System.err.println("usage: ./target/universal/stage/bin/consoleapp [ last_n_words ]");
    System.exit(2);
  }
  // ...
  if (args.length == 1) {
    lastNWords = Integer.parseInt(args[0]);
    if (lastNWords < 1) {
      throw new NumberFormatException();
    }
  }

Command-line arguments are very widely used, but it quickly becomes tedious to handle them when more than one or two arguments are required and when we want to have *named* arguments instead of position-based ones so we can provide them in any order.
Unsurprisingly, as is the case for many common tasks or concerns not addressed by the standard library bundled with the language SDK, there are third-party libraries for handling command-line argument parsing.

For example, we can use Li Haoyi's `mainargs <https://github.com/com-lihaoyi/mainargs>`_ library by declaring this dependency in our build configuration

.. code-block:: scala

  "com.lihaoyi" %% "mainargs" % "0.6.3",

and 

.. code-block:: scala

  // external entry point into Scala application
  def main(args: Array[String]): Unit = ParserForMethods(this).runOrExit(args.toIndexedSeq)

  // internal main method with arguments annotated for parsing
  @main
  def run(
      @arg(short = 'c', doc = "size of the sliding word cloud") cloudSize: Int = 10,
      @arg(short = 'l', doc = "minimum word length to be considere") minLength: Int = 6,
      @arg(short = 'w', doc = "size of the sliding FIFO queue") windowSize: Int = 1000,
      @arg(short = 's', doc = "number of steps between word cloud updates") everyKSteps: Int = 10,
      @arg(short = 'f', doc = "minimum frequency for a word to be included in the cloud") minFrequency: Int = 3) = 

    logger.debug(f"howMany=$cloudSize minLength=$minLength lastNWords=$windowSize everyKSteps=$everyKSteps minFrequency=$minFrequency")
    // ...           

Based on the formal argument names and their ``@arg`` annotations, the library generates a parser that looks for the arguments based on their long or short names and associated values;
arguments can have default values.
In addition, the generated code can handle a ``--help`` option, which prints a UNIX-style usage summary.

.. code-block:: bash

  $ ./target/universal/stage/bin/myapp -- --help
  run
    -c --cloud-size <int>     size of the sliding word cloud
    -l --min-length <int>     minimum word length to be considere
    -w --window-size <int>    size of the sliding FIFO queue
    -s --every-ksteps <int>   number of steps between word cloud updates
    -f --min-frequency <int>  minimum frequency for a word to be included in the cloud

For example, we could run the application with these arguments:

.. code-block:: bash

  $ ./target/universal/stage/bin/myapp -- -c 3 -l 2 -w 5  


Finding good third-party libraries
``````````````````````````````````

For most programming languages, platforms, and other ecosystems, there are lists of "awesome" libraries and tools.
For a particular language, search for "awesome" followed by the name of the language.

In Scala's case, we would come across this here list:

  https://github.com/lauris/awesome-scala

Within it, we can then look for the desired concern or purpose, such as "command line interfaces", where we find mainargs among several other choices.
It can be hard to choose a specific library; 
some typical criteria are:

  - ease of use
  - quality of documentation
  - popularity
  - active development status
  - code quality
  - number of dependencies (lower is usually better)
  - security (absence of known vulnerabilities)


The role of logging
~~~~~~~~~~~~~~~~~~~

Logging is a common dynamic nonfunctional requirement that is useful throughout the lifecycle of a system.
Logging can be challenging because it is a cross-cutting concern that arises throughout the codebase.

In its simplest form, logging can consist of ordinary print statements, preferably to the *standard error* stream (``stderr``):

.. code-block:: scala

  System.err.println("something went wrong: " + anObject)

This allows displaying (or redirecting) error messages separately from output data.

For more complex projects, it is advantageous to be able to configure logging centrally, such as suppressing log messages below a certain `log level <https://stackoverflow.com/questions/2031163/when-to-use-the-different-log-levels>`_ indicating the severity of the message, configuring the destination of the log messages, or disabling logging altogether.

*Logging frameworks* have arisen to address this need.
Modern logging frameworks have very low performance overhead and are a convenient and effective way to achieve professional-grade `separation of concerns <https://en.wikipedia.org/wiki/Separation_of_concerns>`_ with respect to logging.

Proper logging is perhaps more important in applications where one doesn't normally see the console output, such as apps with a graphical user interface and back-end server apps.
In those cases, logging allows ongoing monitoring of app progress, as well as error analysis if something isn't working.


Logging in Scala
````````````````

A popular choice found on the `Awesome Scala <https://github.com/lauris/awesome-scala>`_ list, the `log4s <https://github.com/Log4s/log4s>`_ wrapper provides a convenient logging mechanism for Scala.
To use log4s minimally, the following steps are required:

- Add external dependencies for log4s and a simple slf4j backend implementation:

  .. code-block:: scala

    "org.log4s" %% "log4s" % "1.8.2",
    "org.slf4j" % "slf4j-simple" % "1.7.30"

- If you require a more verbose (lower severity) log level than the default of ``INFO``, such as ``DEBUG``, add a configuration file ``src/main/resources/simplelogger.properties`` with contents:

  .. code-block:: scala

    org.slf4j.simpleLogger.defaultLogLevel = debug

- Now you are ready to access and use your logger:

  .. code-block:: scala

    private val logger = org.log4s.getLogger
    logger.debug(f"howMany = $howMany minLength = $minLength lastNWords = $lastNWords")


  This produces informative debugging output such as:

  .. code-block:: bash

    [main] DEBUG edu.luc.cs.cs371.topwords.TopWords - howMany = 10 minLength = 6 lastNWords = 1000


.. _subsecConstantSpace:

The importance of constant-space complexity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Common application scenarios involve large volumes of input data or infinite input streams, e.g., sensor data from an internet-of-things device.
To achieve the nonfunctional requirements of reliability/availability and scalability for such applications, it is critical to ensure that the application does not exceed a constant memory footprint during its execution.
*These considerations apply to any potentially long-running application, be it a console app, mobile app, or back-end service.*

Concretely, whenever possible, this means processing one input item at a time and then forgetting about it, rather than storing the entire input in memory. This version of a program that echoes back and counts its input lines has constant-space complexity:

.. code-block:: scala

  var count = 0
  for line <- lines do
    count += 1 
    println(line)
    if scala.sys.process.stdout.checkError() then sys.exit(1)
  println(line + " lines counted")

By contrast, this version has linear-space complexity and may run out of space on a large volume of input data:

.. code-block:: scala

  var count = 0
  val listOfLines = lines.toList
  for line <- listOfLines do
    count += 1 
    println(line)
    if scala.sys.process.stdout.checkError() then sys.exit(1)
  println(line + " lines counted")

In sum, to achieve constant-space complexity, it is usually best to represent the input data as an iterator instead of converting it to an in-memory collection such as a list.
Iterators support most of the same behaviors as in-memory collections.

To observe a program's memory footprint over time, we would typically use a heap profiler.
For programs running in the Java Virtual Machine (JVM), we can use the standalone version of VisualVM.

For example, the following heap profile (upper right section of the screenshot) shows a flat sawtooth pattern, suggesting constant space complexity even as we are processing more and more input items.
By contrast, if the sawtooth pattern were sloping upward over time, space complexity would increase as we are processing our input, suggesting some function that grows in terms of the input size n.

.. image:: images/heapprofile.png


.. _secDomainModelsOO:

Defining domain models in imperative and object-oriented languages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In imperative and object-oriented languages, the basic type abstractions are

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

- (structural) recursion: defining a type in terms of itself, usually involves aggregation and variation

  - example: a tree interface with implementation classes for leaves and interior nodes

- genericity (type parameterization): when a type is parametric in terms of one or more type parameters

  - example: collections parametric in their element type

In an object-oriented language, we commonly use a combination of design patterns (based on these basic abstractions) to represent domain model structures and associated behaviors:

- https://github.com/lucoodevcourse/shapes-android-java
- https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/expressions/SimpleExpressions.java
- https://github.com/LoyolaChicagoCode/misc-java/blob/master/src/main/java/vexpressions/VisitorExpressions.java
- https://github.com/lucoodevcourse/misc-java/tree/master/src/main/java/treesearch/Tree.java

Object-oriented Scala as a "better Java"
````````````````````````````````````````

Scala offers various improvements over Java, including:

- `unified types <https://docs.scala-lang.org/scala3/book/first-look-at-types.html>`_
- `standalone higher-order functions (lambdas) <https://docs.scala-lang.org/scala3/book/taste-functions.html>`_
- `standalone objects <https://docs.scala-lang.org/scala3/book/taste-objects.html>`_
- `tuples <https://docs.scala-lang.org/scala3/book/taste-collections.html#tuples>`_
- `advanced enums <https://docs.scala-lang.org/scala3/book/taste-modeling.html#enums>`_, `case classes <https://docs.scala-lang.org/scala3/book/taste-modeling.html#case-classes>`_ and `pattern matching <https://docs.scala-lang.org/scala3/book/domain-modeling-fp.html#modeling-the-operations>`_
- `traits <https://docs.scala-lang.org/scala3/book/domain-modeling-oop.html>`_: generalization of interfaces and restricted form of abstract classes, can be combined/stacked
- package structure decoupled from folder hierarchy
- `null safety <https://docs.scala-lang.org/scala3/reference/other-new-features/explicit-nulls.html>`_: ensuring at compile-time that an expression cannot be null
- `multiversal equality <https://docs.scala-lang.org/scala3/book/ca-multiversal-equality.html>`_: making sure apples are compared only with other apples
- `higher-kinded types <https://earldouglas.com/posts/higher-kinded.html>`_ (advanced topic)

More recent versions of Java, however, have started to echo some these advances:

- lambda expressions
- default methods in interfaces
- local type inference
- streams

We will study these features as we encounter them.

The following examples illustrate the use of Scala as a "better Java" and the transition to some of the above-mentioned improvements:

- https://github.com/lucproglangcourse/shapes-oo-scala
- https://github.com/lucproglangcourse/expressions-scala
- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchart.sc
- https://github.com/lucproglangcourse/misc-explorations-scala/blob/master/orgchartGeneric.sc


Modularity and dependency injection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: To wrap your head around this section, you may want to start by recalling/reviewing the `stopwatch example <https://github.com/lucoodevcourse/stopwatch-android-java>`_ from COMP 313/413 (intermediate object-oriented programming).
  In that app, the model is rather complex and has three or four components that depend on each other.
  After creating the instances of those components, you had to connect them to each other using setters.
  *Does that ring a bell?*
  In this section and the pertinent examples, we are achieving basically the same goal by plugging two or more Scala traits together declaratively.


Design goals
````````````

We pursue following design goals tied to the nonfunctional code quality requirements:

- *testability*
- *modularity* for separation of concerns
- *reusability* for avoidance of code duplication ("DRY")

In particular, to manage the growing complexity of a system, we usually try to decompose it into its design dimensions, e.g.,

- mixing and matching interfaces with multiple implementations
- running code in production versus testing

We can recognize these in many common situations, including the examples listed below.

In object-oriented languages, we often use classes (and interfaces) as the main mechanism for achieving these design goals.


Scala traits
````````````

Scala traits are *abstract* types that can serve as fully abstract interfaces as well as partially implemented, composable building blocks (mixins).
Unlike Java interfaces (prior to Java 8), Scala traits can have method implementations (and state).
The `Thin Cake idiom <http://www.warski.org/blog/2014/02/using-scala-traits-as-modules-or-the-thin-cake-pattern/>`_ shows how traits can help us achieve our design goals.

.. note:: We deliberately call *Thin Cake* an *idiom* as opposed to a pattern because it is *language-specific*.

We will rely on the following examples for this section:

- https://github.com/lucproglangcourse/consoleapp-java-sbt
- https://github.com/lucproglangcourse/processtree-scala
- https://github.com/lucproglangcourse/iterators-scala

First, to achieve testability, we can define the desired functionality, such as ``common.IO``, as its own trait instead of a concrete class or part of some other trait such as ``common.Main``.
Such traits are *providers* of some functionality, while building blocks that use this functionality are *clients*, such as``common.Main`` (on the production side) and ``PrintSpec`` (on the testing side).
Specifically, in the process tree example, we use ``PrintSpec`` to test ``common.IO`` in isolation, independently of ``common.Main``.

To avoid code duplication in the presence of the design dimensions mentioned above, we can again leverage Scala traits as building blocks.
Along some of the dimensions, there are three possible roles:

- *provider*, e.g., the specific implementations `MutableTreeBuilder`, `FoldTreeBuilder`, etc.
- *client*, e.g., the various main objects on the production side, and the `TreeBuilderSpec` on the testing side
- *contract*, the common abstraction between provider and client, e.g., `TreeBuilder`

Usually, when there is a common contract, a provider *overrides* some or all of the abstract behaviors declared in the contract.
Some building blocks have more than one role. E.g., ``common.Main`` is a client of (depends on) ``TreeBuilder`` but provides the main application behavior that the concrete main objects need.
Similarly, ``TreeBuilderSpec`` also depends on ``TreeBuilder`` but provides the test code that the concrete test classes (``Spec``) need.
This arrangement enables us to mix-and-match the desired ``TreeBuilder`` implementation with either ``common.Main`` for production or ``TreeBuilderSpec`` for testing.


The following figure shows the roles of and relationships among the various building blocks of the process tree example.

.. figure:: images/ProcessTreeTypeHierarchy.png

The `iterators example <https://github.com/lucproglangcourse/iterators-scala>`_ includes additional instances of trait-based modularity in its ``imperative/modular`` package.


.. note:: For pedagogical reasons, the process tree and iterators examples are overengineered relative to their simple functionality:
	  To increase confidence in the functional correctness of our code, we should test it;
	  this requires testability, which drives the modularity we are seeing in these examples.
	  In other words, the resulting design complexity is the cost of testability.
	  On the other hand, a more realistic system would likely already have substantial design complexity in its core functionality for separation of concerns, maintainability, and other nonfunctional quality reasons;
	  in this case, the additional complexity introduced to achieve testability would be comparatively small.


Trait-based dependency injection
````````````````````````````````

In the presence of modularity, `dependency injection <https://en.wikipedia.org/wiki/Dependency_injection>`_ (DI) is a technique for supplying a dependency to a client from outside, thereby relieving the client from the responsibility of "finding" its dependency, i.e., performing *dependency lookup*.
In response to the popularity of dependency injection, numerous DI frameworks, such as Spring and Guice, have arisen.

The Thin Cake idiom provides basic DI in Scala without the need for a DI framework.
To recap, ``common.Main`` cannot run on its own but declares by extending ``TreeBuilder`` that it requires an implementation of the ``buildTree`` method.
One of the ``TreeBuilder`` implementation traits, such as ``FoldTreeBuilder`` can satisfy this dependency.
The actual "injection" takes place when we inject, say, ``FoldTreeBuilder`` into ``common.Main`` in the definition of the concrete main object ``fold.Main``.
