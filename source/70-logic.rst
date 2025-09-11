The Logic Programming Paradigm
------------------------------


Logic programming is a programming paradigm based on formal logic. Programs are written as sets of facts and rules, and computation is performed by querying these facts and rules. Prolog is the most well-known logic programming language.

Hello World in Prolog
~~~~~~~~~~~~~~~~~~~~~

Prolog does not have traditional I/O, but you can define a simple fact and query it:

.. code-block:: prolog

  % hello_world.pl
  hello :- write('Hello, world!'), nl.

To run the query:

.. code-block:: prolog

  ?- hello.
  % Output: Hello, world!


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