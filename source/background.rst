Background
----------

In this section, we establish a practical context for the study of programming languages.


Overview of a lightweight development process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A successful development process usually comprises these minimal elements: 

- `automated regression testing <https://martinfowler.com/bliki/SelfTestingCode.html>`_

  - tests represent expectations of how the software should behave
  - when expressed as code, these are

    - fun to produce (like other coding)
    - convenient to run frequently

  - fix subject-under-test (SUT) (not tests) until tests pass

  - retest every time

    - a feature is added

    - the code is refactored

- `refactoring <https://www.refactoring.com/>`_

  - improve the quality of the code without changing its behavior

    - macro level: nonfunctional requirements (quality factors)

    - micro level: `code smells <https://refactoring.guru/smells/smells>`_

  - `catalog of refactorings <https://refactoring.com/catalog/>`_

- `continuous integration <https://www.martinfowler.com/articles/continuousIntegration.html>`_


Software requirements
~~~~~~~~~~~~~~~~~~~~~

In most cases, we develop software to provide some form of value:

- learn a language, library, framework, platform, technique, or tool
  (see also the `ThoughtWorks Technology Radar <https://www.thoughtworks.com/radar>`_)
- solve a problem
- produce an asset

There is usually some tension among these three activities.

The basic categories of requirements are

- functional (FR)

  - output as function of input: `y = f(x)`
  - or some other description of observable behavior

    - batch
    - interactive/event-based

- nonfunctional (NFR): additional properties of `f`, e.g.

  - testability

    - most important nonfunctional requirement
    - allows testing whether functional requirements are met
    - good architecture often happens as a side-effect (APPP pp. 36-38), such as separating I/O from core functionality

  - performance
  - scalability

    - e.g. performance for large data sets: asymptotic order of complexity 
    - (big-Oh) in terms of input size n

  - reliability
  - maintainability
  - static versus dynamic NFRs

Several common questions and issues related to requirements arise:

- *how do requirements relate to the project development lifecycle?*
- *BUFD versus MVP*
- *how do testing and refactoring relate to requirements?*

The following figure by Kazman relates unit operations (high-level generalizations of refactorings) and software quality factors (nonfunctional requirements).

.. figure:: images/KazmanQualityFactors.png


Software design principles and patterns
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The software development community has identified various principles intended to guide the design and development process, for example:

- `DRY <http://en.wikipedia.org/wiki/Don%27t_repeat_yourself>`_ (don't repeat yourself) 
- `SoC <https://en.wikipedia.org/wiki/Separation_of_concerns>`_ (separation of concerns)
- `SOLID <https://en.wikipedia.org/wiki/SOLID_(object-oriented_design>`_ 

The community has also developed a body of `design patterns <https://sourcemaking.com/design_patterns>`_ that represent reusable solutions to recurring problems. Some key design patterns we will rely on in this course include

- Iterator
- Strategy
- Composite
- Decorator
- Visitor
- Abstract Factory
- Observer

We will recap these throughout the course as needed.


Programming language history and paradigms
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The resources in this section cover fundamental models of computation, language paradigms, and language principles.

- `overview talk <http://klaeufer.github.com/luc-amc.html>`_ by Läufer and Thiruvathukal
- `programming languages paradigms: diagram <https://www.info.ucl.ac.be/~pvr/paradigmsDIAGRAMeng108.jpg>`_ by Van Roy
- `programming languages paradigms: book chapter <https://www.info.ucl.ac.be/~pvr/VanRoyChapter.pdf>`_ by Van Roy
- :doc:`principles` by MacLennan
- `Turing completeness <https://en.wikipedia.org/wiki/Turing_completeness>`_
- `Church-Turing thesis <https://en.wikipedia.org/wiki/Church%E2%80%93Turing_thesis>`_

.. todo:: expand into a proper section  

  
Popularity indices and performance comparisons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are a number of programming language popularity indices and performance comparisons.
Before drawing any conclusions from these indices, it is important to understand their *methodology*. 

- `PYPL PopularitY of Programming Language index <https://pypl.github.io>`_
- `TIOBE programming community index <http://www.tiobe.com/tiobe-index>`_
- `GitHub language popularity <https://www.techworm.net/2016/09/top-10-popular-programming-languages-github.html>`_
- `Programming languages shootout benchmark <http://benchmarksgame.alioth.debian.org>`_



Options for running Scala code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this section, we discuss the different options for running Scala code, including applications and tests.

- The simplest way to run Scala code fragments is through the Scala REPL (read-eval-print loop).
  We can launch the Scala REPL and then evaluate definitions and expressions::

    $ scala
    Welcome to Scala 2.12.1 (Java HotSpot(TM) 64-Bit Server VM, Java 1.8.0_102).
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

  You can also run simple scripts (with optional command-line arguments) directly through the scala interpreter::

    $ cat > blah.scala
    println(args.toList)
    $ scala blah.scala 1 2 3
    List(1, 2, 3)

    
- In a Scala IDE such as IntelliJ IDEA, we can run Scala applications (classes/objects with a ``main`` method or objects extending the ``App`` trait) and Scala tests from within the IDE. To pass command-line arguments to an application, we have to create a suitable run configuration.

- In IntelliJ IDEA, Scala worksheets are a convenient way to do REPL-style exploratory programming while being able to modify and save all your code.
  Check out `this example <https://github.com/lucproglangcourse/misc-explorations-scala>`_, especially the simple option and list examples. For simple testing, you can intersperse assertions within your code.
  Worksheets can live in any folder and coexist with other code.
  So you can start exploring something in a worksheet and then move it into your production code when appropriate.
  The Eclipse Scala IDE has a similar feature.

- It is best to use `sbt <https://www.scala-sbt.org/>`_ (the Scala Build Tool) for projects with one or more external dependencies because of sbt's (and similar build tools') ability to manage these dependencies in a declarative way::

    $ sbt test 
    $ sbt run
    $ sbt "run arg1 arg2 ..."
    $ sbt "runMain my.pkg.Main arg1 arg2 ..."
    $ sbt test:run
    
    
  In addition, sbt allows you to start a REPL that exposes the code in your project and its managed dependencies.
  This is the preferred way to explore existing libraries::

    $ sbt console

    
  You can also pull in the additional dependencies from the test scope::

    $ sbt test:console

  If you want to bypass your own code in case of, say, compile-time errors, you can use one of these tasks::

    $ sbt consoleQuick 
    $ sbt test:consoleQuick 

  In conjunction with a `text editor <https://www.gnu.org/software/emacs>`_, sbt's `triggered execution <http://www.scala-sbt.org/0.13/docs/Triggered-Execution.html>`_ for testing will significantly shorten the edit-compile-run/test cycle, for example::

    $ sbt
    ...
    > ~ test


- Finally, to turn an sbt-based Scala application into a script you can run outside sbt, you can use the `sbt-native-packager <https://github.com/sbt/sbt-native-packager>`_ plugin.
  To use this plugin, add this line to the end of ``build.sbt``::

    enablePlugins(JavaAppPackaging) 

  and this one to ``project/plugins.sbt``::

    addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.1.4") 

  Then, after any change to your sources, you can create/update the script and run it from the command line like so::

    $ sbt stage
    ...
    $ ./target/universal/stage/bin/myapp-scala arg1 arg2 ...


The role of console applications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Console applications have always been an important part of the Unix command-line environment.
The typical console application interacts with its environment in the following ways:

- zero or more application-specific *command-line arguments* for passing options to the application: ``app arg1 arg2 ...``
- *standard input* (stdin) for reading the input data
- *standard output* (stdout) for writing the output data
- *standard error* (stderr) for displaying error messages separately from the output data

Applications written in this way can function as composable building blocks using Unix pipes.
Using these standard I/O mechanisms is much more flexible than reading from or writing to files whose names are hardcoded in the program.

E.g., the ``yes`` command outputs its arguments forever on consecutive output lines,
the ``head`` command outputs a finite prefix of its input,
and the ``wc`` command counts the number of characters, words, or lines::

    yes hello | head -n 10 | wc -l

You may wonder how the upstream (left) stages in the pipeline know when to terminate.
Concretely, how does the ``yes`` command know to terminate after ``head`` reads the first ten lines.
When ``head`` is done, it closes its input stream, and ``yes`` will receive an error signal called ``SIGPIPE`` when it tries to write further data to that stream.
The default response to this error signal is termination.
    
We can also use the control structures built into the shell. E.g., the following loop prints an infinite sequence of consecutive integers starting from 0::

    n=0 ; while :; do echo $n ; ((n=n+1)) ; done

These techniques are useful for producing test data for our own applications.
To this end, we can redirect output to a newly created file using this syntax::

    n=0 ; while :; do echo $n ; ((n=n+1)) ; done > testdata.txt

If ``testdata.txt`` already exists, it will be overwritten when using this syntax.
We can also append to an existing file::

    ... >> testdata.txt

Similarly, we can redirect input from a file using this notation::

    wc -l < testdata.txt

There is a close relationship between Unix pipes and functional programming: When viewing a console application as a function that transforms its input to its output, Unix pipes correspond to function composition. The pipeline ``p | q`` corresponds to the function composition ``q o p``.
  

Console applications in Scala
`````````````````````````````

The following techniques are useful for creating console applications in Scala.
As in Java, command-line arguments are available to a Scala application as ``args`` of type ``Array[String]``.

We can read the standard input as lines using this iterator::

    val lines = scala.io.Source.stdin.getLines 

This gives you an iterator of strings with each item representing one line. When the iterator has no more items, you are done reading all the input. (See also this concise reference.)

To break the standard input down further into words, we can use this recipe::

    val words = lines.flatMap(_.split("\\W+"))

In Scala, ``print`` and ``println`` print to stdout.

Console applications written in this way can be part of a Unix pipeline only to a limited extent.
Unfortunately, the Java virtual machine ignores the ``SIGPIPE`` error signal, so we cannot use Scala (or Java) console applications as upstream components that produce an infinite output sequence and depend on this signal.


The importance of constant-space complexity
```````````````````````````````````````````

Common application scenarios involve large volumes of input data or infinite input streams, e.g., sensor data from an internet-of-things device.
To achieve reliability and scalability of such applications, it is critical to ensure that the application does not exceed a constant memory footprint during its execution.

Concretely, whenever possible, this means processing one input item at a time and then forgetting about it, rather than storing the entire input in memory. This version of a program that echoes back and counts its input lines has constant-space complexity::

    var count = 0
    for (line <- lines) {
      println(line)
      count += 1
    }
    println(line + " lines counted")

By contrast, this version has linear-space complexity and may run out of space on a large volume of input data::

    var count = 0
    val listOfLines = lines.toList
    for (line <- listOfLines) {
      println(line)
      count += 1
    }
    println(line + " lines counted")
  
In sum, to achieve constant-space complexity, it is usually best to represent the input data as an iterator instead of converting it to an in-memory collection such as a list.
Iterators support most of the same behaviors as in-memory collections.



Options for testing Scala code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are various basic techniques and libraries/frameworks for testing Scala code.

The simplest way is to intersperse assertions within your code.
This is particularly effective for scripts and worksheets::

    val l = List(1, 2, 3)
    assert { l.contains(2) }

The following testing libraries/frameworks work well with Scala.
    
- The familiar `JUnit <http://junit.org>`_ can be used directly.
- `ScalaCheck <http://scalacheck.org>`_ is a testing framework for Scala that emphasizes property-based testing, including universally quantified properties, such as "for all lists ``x`` and ``y``, the ``(x ++ y).length`` is equal to ``x.length + y.length``"
- `ScalaTest <http://scalatest.org>`_ is a testing framework for Scala that supports a broad range of test styles including behavior-driven design, including integration with ScalaCheck.
- `specs2 <http://etorreborre.github.io/specs2/>`_ is a specification-based testing library that also supports integration with ScalaCheck.

For faster turnaround, we can combine these techniques with triggered execution. 

The `echotest <https://github.com/lucproglangcourse/echotest-scala>`_ example shows some of these libraries in action.


Detailed case study
~~~~~~~~~~~~~~~~~~~

The `process tree <https://github.com/lucproglangcourse/processtree-scala>`_ example illustrates the various topics from this chapter.
Examples in various other languages are `available <https://github.com/lucproglangcourse?q=processtree>`_ as well. 
