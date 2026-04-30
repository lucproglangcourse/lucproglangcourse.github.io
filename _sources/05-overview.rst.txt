Overview
--------
 
In this chapter, we provide an outline of the course, along with a brief motivation and key learning outcomes.  


Course Information
~~~~~~~~~~~~~~~~~~

- `COMP 371/471 course descriptions <https://catalog.luc.edu/course-descriptions/comp/>`_
- `Department of Computer Science <http://luc.edu/cs>`_
- `Loyola University Chicago <http://luc.edu>`_


Motivation
~~~~~~~~~~

There are a number of reasons why you would want to study programming languages. To name a few:

- Knowing several programming *paradigms* will help you think about more problems in better ways.
- Knowing several programming *languages* will help you implement your solutions in better ways.
- The subject matter is exciting and intellectually challenging.
- Increasing numbers of local, national, and global employers love it!


Key learning outcomes
~~~~~~~~~~~~~~~~~~~~~

We deliberately chose the learning outcomes for this course to complement other courses in your computer science or software engineering curriculum. Upon entering this course, you will already be familiar with the imperative and object-oriented paradigms, coming from languages such as Java, C++, C#, or Python. Most likely, you will also be familiar with basic machine architecture and memory management using C or C++.

In this course, we will pursue two overarching learning outcomes and three more specific ones:

- an overview of programming paradigms (see :doc:`/10-background`, :doc:`/75-otherparadigms`)
- an understanding of the programming language design space (see :doc:`/10-background`, :doc:`/80-principles`)
- proficiency in functional programming (see :doc:`/40-functional`)
- an understanding of program representation and interpretation/execution (see :doc:`/50-representationinterpretation`)
- basic competence in concurrent programming (see :doc:`/60-concurrency`)

Given the widespread availability in multi-core hardware ranging from mobile devices to enterprise servers, there is a growing interest in programming paradigms and techniques that will take advantage of this hardware. Functional programming, which de-emphasizes mutable state, in conjunction with suitable concurrency constructs, is particularly useful. We will also "look under the hood" by studying how to represent programs and interpret, execute, or otherwise process those representations.


Resources
~~~~~~~~~

For paradigm-specific reading lists and recommended texts, see :doc:`/83-resources`.

You might also find the following general resources useful as starting points:

- Presentation by Martin Odersky: Scala with Style `(YouTube) <http://www.youtube.com/watch?v=kkTFx3-duc8>`_
- Interview with Simon Peyton-Jones on Functional Programming and Haskell `(SE Radio audio podcast) <http://www.se-radio.net/episode-108-simon-peyton-jones-on-functional-programming-and-haskell>`_
- Presentation by Läufer, Thiruvathukal, and Kaylor: The Promise of Statically Typed Functional Programming `(visual presentation) <_static/luc-amc.html>`_

The presentation covers three main arguments: the promise of statically typed functional programming for program correctness; the broader context of modern multi-core hardware and cloud computing; and a comparison of languages (Scala, Haskell, Clojure) in this light.

Course outline
~~~~~~~~~~~~~~

Here is a more detailed course outline (subject to revision).

The course begins with context and background (software engineering practices, language paradigms), then surveys the major paradigms in depth: imperative, object-oriented, functional, logic, and concurrent. We then "look under the hood" at program representation and interpretation. A final chapter surveys additional paradigms (reactive, dataflow, AOP) before concluding with cross-cutting principles.

.. include:: detailedoutline.txt


Bloom's taxonomy
~~~~~~~~~~~~~~~~

The letters refer to the successive levels of learning from the cognitive domain of `Bloom's taxonomy <https://en.wikipedia.org/wiki/Bloom's_taxonomy#Cognitive>`_:

- K: know/remember the term
- C: comprehend/understand the concept
- A: apply the technique
- analyze/evaluate/create (advanced levels)

.. list-table:: Learning outcomes mapped to Bloom levels
   :header-rows: 1
   :widths: 60 40

   * - Learning outcome
     - Bloom level(s)
   * - Overview of programming paradigms
     - K, C
   * - Understanding of the PL design space
     - K, C
   * - Proficiency in functional programming
     - C, A
   * - Understanding of program representation and interpretation
     - C, A
   * - Basic competence in concurrent programming
     - C, A
