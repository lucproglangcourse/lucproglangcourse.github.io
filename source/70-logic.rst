The Logic Programming Paradigm
------------------------------

In this chapter, we introduce the logic programming paradigm, which is based on formal logic. Programs are written as sets of facts and rules, and computation is performed by querying these facts and rules. Prolog is the most well-known logic programming language.


Core Elements
~~~~~~~~~~~~~

The logic programming paradigm is characterized by **computation as logical deduction**.  
Programs are expressed as sets of *facts* and *rules*, and execution consists of 
querying these rules to derive conclusions. Rather than specifying *how* to compute, 
logic programs specify *what* relationships hold, leaving the search for solutions 
to the underlying inference engine.


Facts
```````````````````````````````

- Basic assertions about objects and relationships in the domain of discourse.
- Represent ground truths that the program can use in reasoning.

Rules
``````````````````````````````

- Conditional statements (Horn clauses) that describe relationships between facts.
- Expressed as ``Head :- Body``, meaning *Head is true if Body is true*.

Queries
``````````````````````````````

- Questions posed to the inference engine.  
- The engine attempts to satisfy queries using facts and rules.

Unification
``````````````````````````````

- A process of making two logical terms syntactically identical by finding 
  consistent substitutions for variables.  
- Drives both matching of queries with rules and parameter passing.
  See also pattern matching in :doc:`/40-functional`, which uses a similar idea of matching terms by structure.

Backtracking
``````````````````````````````

- The search mechanism for exploring alternative inference paths.
- If one path fails, the engine backtracks to try other possibilities.

Non-Determinism
``````````````````````````````

- Multiple possible solutions may exist for a query.
- The inference engine can generate all solutions by systematically backtracking.

Declarative Semantics
``````````````````````````````

- Programs describe *what is true* rather than prescribing *how to compute*.  
- Execution is a process of theorem proving, guided by the inference rules.

Other Elements
``````````````````````````````

- **Negation as failure**: something is assumed false if it cannot be proven true.  
- **Constraint logic programming (CLP)**: extends logic programming with constraints 
  over domains such as integers, reals, or finite sets.  
  For a broader overview of constraint programming, see :doc:`/75-otherparadigms`.
- **Meta-programming**: programs can reason about themselves by treating rules and 
  goals as data.



.. note:: **Logic programming vs. other paradigms**

   Unlike *imperative* programs that specify *how* to compute (step-by-step state changes), and unlike *functional* programs that express *what* to compute (as a composition of functions), logic programs specify *what relationships hold* and let the inference engine find solutions. This makes logic programming naturally *relational*: a predicate such as ``grandparent(X, Y)`` can be queried in multiple directions — "who are X's grandchildren?", "who are Y's grandparents?", or "are X and Y related?" — without writing separate functions for each direction. See also the discussion of unification in :doc:`/50-representationinterpretation` and constraint programming in :doc:`/75-otherparadigms`.


Hello World in Prolog
~~~~~~~~~~~~~~~~~~~~~

Prolog programs are *query-driven* rather than entry-point-driven: instead of a ``main`` method, you issue a query at the top level and the inference engine searches for solutions. Prolog does support I/O predicates (``write/1``, ``nl/0``, ``read/1``, ``format/2``, etc.); the ``hello/0`` fact below uses them:

.. code-block:: prolog

  % hello_world.pl
  hello :- write('Hello, world!'), nl.

To run the query:

.. code-block:: prolog

  ?- hello.
  % Output: Hello, world!


.. note:: You can use SWI-Prolog, a popular and free Prolog implementation, to run the following examples live. SWI-Prolog is available for Windows, macOS, and Linux; an online version is also available at `SWISH <https://swish.swi-prolog.org/>`_.



Basic Facts and Rules Example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Here is a simple Prolog program that defines family relationships:

.. code-block:: prolog

  % family.pl
  parent(john, mary).
  parent(mary, susan).

  grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

You can query for grandparents:

.. code-block:: prolog

  ?- grandparent(john, susan).
  % Output: true.

  ?- grandparent(mary, susan).
  % Output: false.

In the following queries, the variable `X` is used to find all possible values that satisfy the relationship. In Prolog, variables start with an uppercase letter and represent unknowns that Prolog tries to solve for.

.. code-block:: prolog

  ?- grandparent(john, X).
  % Output: X = susan.

  ?- grandparent(X, susan).
  % Output: X = john.

  ?- grandparent(susan, X).
  % Output: false.


8-Queens Example in Prolog
~~~~~~~~~~~~~~~~~~~~~~~~~~

The 8-queens problem is to place 8 queens on a chessboard so that no two queens threaten each other.

The 8-queens solution uses a *generate-and-test* strategy: ``member/2`` generates candidate row positions for each queen on backtracking, and ``safe/1`` tests that no two queens attack each other. Prolog's backtracking automatically explores the search tree: if placing a queen in a given row leads to a conflict, Prolog undoes that choice (backtracks) and tries the next candidate.

.. note:: **Tracing the first few steps**

   Prolog first tries ``Q = 1`` for the first queen (column 1). It then recursively tries to place the remaining queens. If ``safe`` fails at any point, Prolog backtracks and tries ``Q = 2`` for the conflicting queen, then ``Q = 3``, etc. The first complete solution found is ``[1, 5, 8, 6, 3, 7, 2, 4]``.

.. code-block:: prolog

  % 8queens.pl
  safe([]).
  safe([Q|Qs]) :- safe(Qs), no_attack(Q, Qs, 1).

  no_attack(_, [], _).
  no_attack(Q, [Q1|Qs], D) :-
    Q =\= Q1,
    abs(Q - Q1) =\= D,
    D1 is D + 1,
    no_attack(Q, Qs, D1).

  queens([], []).
  queens([N|Ns], [Q|Qs]) :-
    queens(Ns, Qs),
    member(Q, [1,2,3,4,5,6,7,8]),
    \+ member(Q, Qs),
    safe([Q|Qs]).

  solve_queens(Solution) :-
    queens([1,2,3,4,5,6,7,8], Solution).

To run the query:

.. code-block:: prolog

  ?- solve_queens(S).
  % S = [1, 5, 8, 6, 3, 7, 2, 4] .

To generate several solutions, use the semicolon (``;``) after each answer:

.. code-block:: prolog

  ?- solve_queens(S).
  % S = [1, 5, 8, 6, 3, 7, 2, 4] ;
  % S = [1, 6, 8, 3, 7, 4, 2, 5] ;
  % S = [1, 7, 4, 6, 8, 2, 5, 3] ;
  % S = [1, 7, 5, 8, 2, 4, 6, 3] ;
  % ... (more solutions) ...
  % false.

In this example, the ``solve_queens/1`` predicate finds a valid arrangement of queens on the chessboard, represented as a list where the index represents the column and the value at that index represents the row of the queen in that column.


Performance, nondeterminism, and the cut operator
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the most infamous features of Prolog is the **cut** operator, written as ``!``.  
Its purpose is to **prune the search space** by committing the inference engine to 
choices made so far and preventing backtracking past that point.

- **Intended use**: control search to improve efficiency or enforce determinism.
- **Semantics**: when the engine encounters ``!``, it succeeds immediately but 
  discards all alternative choices that led to the current goal.
- **Example**:

  .. code-block:: prolog

     max(X, Y, X) :- X >= Y, !.
     max(X, Y, Y).

  Here, if ``X >= Y`` holds, the cut commits to the first rule, preventing Prolog 
  from also considering the second rule.

- **Benefits**:
  - Allows programmers to fine-tune performance.
  - Makes certain deterministic rules concise.

- **Problems**:
  - Breaks declarative semantics: program meaning now depends on control strategy.
  - Can make logic programs harder to reason about and less portable.
  - Errors involving cut are often subtle and non-intuitive.

Because of these drawbacks, the cut is often described as *"a necessary evil"* or 
*"Prolog’s goto statement"*. More modern logic programming systems (e.g., Mercury, 
constraint logic programming) try to avoid or replace cut with more principled 
mechanisms for controlling search and determinism.


Summary and further reading
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Logic programming offers a radically different model of computation: programs declare *what is true* rather than prescribing *how to compute*. Prolog's execution model — depth-first search with backtracking, driven by unification — makes it natural for problems that can be expressed as constraint satisfaction, pattern matching, or rule-based reasoning: parsing, type inference, planning, and natural language processing.

Compared with the functional paradigm (:doc:`/40-functional`), logic programming is also declarative, but *relational* rather than functional: predicates relate arguments bidirectionally, whereas functions map inputs to outputs unidirectionally. Compared with the imperative paradigm (:doc:`/20-imperative`), logic programs have no explicit control flow; the inference engine determines the order of evaluation.

The cut operator (``!``) is the main escape hatch from pure declarative semantics, trading predictability for performance. Modern systems such as Mercury and Constraint Logic Programming (CLP) provide more principled alternatives.

Further reading:

- Sterling and Shapiro, *The Art of Prolog* (2nd ed., MIT Press, 1994) — comprehensive treatment of Prolog programming techniques.
- `SWI-Prolog manual <https://www.swi-prolog.org/pldoc/>`_ — reference documentation for the most widely used Prolog implementation.
- Bratko, *Prolog Programming for Artificial Intelligence* (4th ed., Pearson, 2011) — applications of Prolog to AI problems.
- `SWISH online Prolog environment <https://swish.swi-prolog.org/>`_ — run Prolog programs in your browser.
- `miniKanren <http://minikanren.org/>`_ — a relational programming language embeddable in Scheme, Clojure, and other languages, inspired by Prolog but with a cleaner semantics.
