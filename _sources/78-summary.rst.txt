Summary
-------

This chapter brings together the major themes of the course and reflects on the relationships among the paradigms studied.


Revisiting the learning outcomes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At the start of the course (:doc:`/05-overview`) we identified five overarching learning outcomes. Here is where each was addressed:

.. list-table::
   :header-rows: 1
   :widths: 40 25 35

   * - Learning outcome
     - Primary chapter(s)
     - Key takeaway
   * - Overview of programming paradigms
     - :doc:`/10-background`, :doc:`/75-otherparadigms`
     - Paradigms are mental models of computation; each emphasises different abstractions and tradeoffs.
   * - Understanding of the PL design space
     - :doc:`/10-background`, :doc:`/80-principles`
     - Language design is guided by principles such as orthogonality, abstraction, and security; these create a structured design space with known tradeoffs.
   * - Proficiency in functional programming
     - :doc:`/40-functional`
     - Functional programming de-emphasises mutable state in favour of immutable values, higher-order functions, algebraic data types, and composable effect types.
   * - Understanding of program representation and interpretation
     - :doc:`/50-representationinterpretation`
     - Programs can be represented as abstract syntax trees; interpreters and compilers process these representations using structured operational semantics or type-directed translation.
   * - Basic competence in concurrent programming
     - :doc:`/60-concurrency`
     - Concurrency introduces nondeterminism and shared-state hazards; strategies include mutual exclusion, confinement, immutability, and higher-level abstractions such as actors and futures.


Paradigm comparison
~~~~~~~~~~~~~~~~~~~~

Each paradigm studied in this course has a characteristic *primary abstraction* and *execution model*:

.. list-table::
   :header-rows: 1
   :widths: 18 20 16 23 23

   * - Paradigm
     - Primary abstraction
     - Mutability
     - Execution model
     - Representative languages
   * - Imperative
     - Statement / variable
     - Central (state = memory)
     - Sequential steps
     - C, Java, Python
   * - Object-oriented
     - Object / message
     - Encapsulated
     - Method dispatch
     - Java, C++, Python, Scala
   * - Functional
     - Function / value
     - Discouraged (immutable preferred)
     - Expression evaluation
     - Haskell, Scala, Clojure, F#
   * - Logic
     - Predicate / relation
     - Absent (pure logic)
     - Query / unification / backtracking
     - Prolog, Mercury
   * - Concurrent
     - Thread / actor / future
     - Shared (hazardous) or confined
     - Interleaved / parallel steps
     - Java, Scala, Go, Erlang


Choosing a paradigm
~~~~~~~~~~~~~~~~~~~~

In practice, modern languages support multiple paradigms. The choice of which paradigm to emphasise depends on the problem structure:

- **Prefer functional style** when state is the primary source of bugs, when the computation is naturally expressed as data transformation, or when parallelism and concurrency are needed — immutability eliminates data-race hazards.
- **Prefer object-oriented style** when the domain has a rich type hierarchy, when encapsulation of mutable state is necessary, or when working within an OO framework or platform.
- **Prefer logic programming** when the problem is naturally expressed as constraint satisfaction, pattern matching over relational data, or rule-based reasoning (e.g., expert systems, type checkers, planners).
- **Prefer concurrent abstractions** (actors, futures, reactive streams) when the problem involves multiple independent, long-running activities, I/O-bound tasks, or event-driven workflows.
- **Combine paradigms** when no single paradigm is dominant — Scala, for example, blends OO and functional programming seamlessly, and Scala's actors (or Cats Effect) add principled concurrency on top.


Cross-cutting themes
~~~~~~~~~~~~~~~~~~~~~

Several themes recur across the paradigms:

**Separation of concerns.**
Whether via modules and traits (OO), pure functions and effect types (functional), or aspects (AOP), the goal is to isolate distinct responsibilities so they can be developed, tested, and reasoned about independently.

**Representation and interpretation.**
Every paradigm requires that programs be represented as data (as ASTs, as Prolog term databases, as F-algebra fixpoints) before they can be interpreted, compiled, or transformed. The program-representation chapter (:doc:`/50-representationinterpretation`) shows this explicitly for an imperative toy language; the same idea underlies Prolog's meta-programming and Scala's macros.

**The cost of expressiveness.**
More expressive paradigms (logic, dependent types, higher-order functions) allow more to be *expressed* statically but may make *execution* less predictable or require more sophisticated tooling. Language design is a continuous negotiation between these forces.


Further directions
~~~~~~~~~~~~~~~~~~~

Students wishing to deepen their knowledge of programming languages and paradigms may find the following resources useful:

- **Types and Programming Languages** by Benjamin Pierce (MIT Press, 2002): the standard graduate-level text on type theory, covering the lambda calculus, type safety, subtyping, and polymorphism.
- **Structure and Interpretation of Computer Programs (SICP)** by Abelson and Sussman (`online <https://mitpress.mit.edu/sites/default/files/sicp/index.html>`_): a classic treatment of functional programming, metacircular evaluation, and language implementation using Scheme.
- `Haskell <https://www.haskell.org/>`_: the canonical pure functional programming language; studying it illuminates the design choices in Scala's functional features.
- `miniKanren <http://minikanren.org/>`_ / `core.logic <https://github.com/clojure/core.logic>`_: relational programming embedded in Scheme and Clojure; a modern, minimalist take on logic programming.
- **Contributing to course examples**: the course examples live at https://github.com/lucproglangcourse. Opening issues, submitting pull requests, and experimenting with new features is an excellent way to consolidate and apply what you have learned.
