Overview
--------

In this chapter, we provide an outline of the course, along with a brief motivation and key learning outcomes.


Motivation
~~~~~~~~~~

There are a number of reasons why you would want to study programming languages. To name a few:

- Knowing several languages will help you solve more problems in better ways.
- The subject matter is exciting and intellectually challenging.
- Google, Meetup, and increasing numbers of local startups love it (from an employer's point of view)!


Key learning outcomes
~~~~~~~~~~~~~~~~~~~~~

We deliberately chose the learning outcomes for this course to complement other courses in your computer science or software engineering curriculum. Upon entering this course, you will already be familiar with the imperative and object-oriented paradigms, coming from languages such as Java, C++, C#, or Python. Most likely, you will also be familiar with basic machine architecture and memory management using C or C++.

In this course, we will pursue one overarching learning outcome and three more specific ones:

- an understanding of the programming language design space
- proficiency in functional programming
- an understanding of program representation and interpretation/execution
- basic competence in concurrent programming

Given the widespread availability in multi-core hardware ranging from mobile devices to enterprise servers, there is a growing interest in programming paradigms and techniques that will take advantage of this hardware. Functional programming, which de-emphasizes mutable state, in conjunction with suitable concurrency constructs, is particularly useful. We will also "look under the hood" by studying how to represent programs and interpret, execute, or otherwise process those representations.


Some starting points for functional programming
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You might find the following resources useful to get into the functional programming mindset:

- Presentation by Martin Odersky: Scala with Style `(YouTube) <http://www.youtube.com/watch?v=kkTFx3-duc8>`_
- Interview with Simon Peyton-Jones on Functional Programming and Haskell `(SE Radio audio podcast) <http://www.se-radio.net/episode-108-simon-peyton-jones-on-functional-programming-and-haskell>`_
- Presentation by Läufer, Thiruvathukal, and Kaylor: The Promise of Statically Typed Functional Programming: Broader Context and Language Comparison `(visual presentation) <http://klaeufer.github.com/luc-amc.html>`_

.. todo:: incorporate visual presentation here

Course outline
~~~~~~~~~~~~~~

Here is a more detailed course outline (subject to revision).

- functional programming (6 weeks)

  - defining algebraic data types

    - scalars: enumerations
    - sublinear structures: numbers, option
    - linear structures: lists, maps
    - nonlinear structures: trees

  - implementing behaviors on algebraic data types

    - pattern matching
    - recursion

  - higher-order functions
  - predefined types and their behaviors
  - recursion patterns
  - higher-kinded types

- programming language representation and interpretation/execution (5 weeks)

  - language design space
  - scanners (lexical analyzers)
  - parsers (syntax analyzers)
  - interpreters and compilers
  - domain-specific languages

- concurrent and parallel programming (4 weeks)

  - parallel collections
  - futures and promises
  - progress reporting and cancelation
  - asynchronous programming/reactive extensions (Rx)
  - advanced mechanisms

    - explicit threads
    - actors
    - software-transactional memory
    - task-parallel library
    - functional data structures

	
Bloom's taxonomy
~~~~~~~~~~~~~~~~

The letters refer to the successive levels of learning from the cognitive domain of `Bloom's taxonomy <http://en.wikipedia.org/wiki/Bloom's_taxonomy#Cognitive>`_:

- K: know/remember the term
- C: comprehend/understand the concept
- A: apply the technique
- analyze/evaluate/create (advanced levels)

.. todo:: map Bloom levels to course outline
