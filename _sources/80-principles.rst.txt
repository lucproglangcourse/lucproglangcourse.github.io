Appendix: Programming Language Design Principles
------------------------------------------------

Bruce MacLennan is a computer scientist whose 1986 textbook *Principles of Programming Languages* (2nd edition, ISBN 0-03-005163-0) synthesised decades of language design experience into a concise set of principles. The list below is adapted from a 2006 blog post by Oliver Wyman (`archived version <https://web.archive.org/web/2006*/http://www.lshift.net/blog/2006/06/24/bruce-j-maclennans-programming-language-design-principles>`_), which paraphrases the principles from the original book; minor wording may differ from MacLennan's text.

These principles are useful both for *evaluating* existing languages (does Java violate Orthogonality? does Python trade Regularity for Simplicity?) and for *understanding design tradeoffs* when implementing a language or library. Throughout the course, we encounter concrete illustrations of most of these principles; cross-references are provided where applicable.

* **Abstraction**: Avoid requiring something to be stated more than once; factor out the recurring pattern.
  *Example*: in Scala, a generic ``fold`` abstracts over the recurring pattern of iterating and accumulating; in Java, extracting a method instead of duplicating code. See :doc:`/40-functional`.
* **Automation**: Automate mechanical, tedious, or error-prone activities.
* **Defense in Depth**: Have a series of defences so that if an error isn’t caught by one, it will probably be caught by another.
* **Information Hiding**: The language should permit modules designed so that (1) the user has all of the information needed to use the module correctly, and nothing more; and (2) the implementor has all of the information needed to implement the module correctly, and nothing more.
* **Labeling**: Avoid arbitrary sequences more than a few items long. Do not require the user to know the absolute position of an item in a list. Instead, associate a meaningful label with each item and allow the items to occur in any order.
* **Localized Cost**: Users should only pay for what they use; avoid distributed costs.
* **Manifest Interface**: All interfaces should be apparent (manifest) in the syntax.
* **Orthogonality**: Independent functions should be controlled by independent mechanisms.
  *Example*: in Scala, ``var``/``val`` (mutability) and ``def``/``val`` (laziness) are orthogonal. In C, the ``static`` keyword has three unrelated meanings (static storage, internal linkage, static class member) — a violation of this principle.
* **Portability**: Avoid features or facilities that are dependent on a particular machine or a small class of machines.
* **Preservation of Information**: The language should allow the representation of information that the user might know and that the compiler might need.
* **Regularity**: Regular rules, without exceptions, are easier to learn, use, describe, and implement.
* **Security**: No program that violates the definition of the language, or its own intended structure, should escape detection.
  *Example*: Scala's static type system, null safety (``-Yexplicit-nulls``), and strict equality (``-language:strictEquality``) enforce this at compile time. Python's dynamic typing defers detection to runtime. See :doc:`/10-background` (NFRs) and :doc:`/40-functional`.
* **Simplicity**: A language should be as simple as possible. There should be a minimum number of concepts, with simple rules for their combination.
* **Structure**: The static structure of the program should correspond in a simple way to the dynamic structure of the corresponding computations.
* **Syntactic Consistency**: Similar things should look similar; different things different.
* **Zero-One-Infinity**: The only reasonable numbers are zero, one, and infinity.
  *Example*: Scala allows zero, one, or many traits to be mixed in (``class C extends A with B with D``); Java allows exactly one superclass — but zero, one, or many interfaces, respecting this principle for interfaces. A language that imposed a limit of "at most 3 traits" would be an arbitrary and therefore bad design choice.

.. seealso::

   - :doc:`/10-background` — the NFRs discussed there (testability, reliability, maintainability) correspond closely to principles such as Security, Abstraction, and Information Hiding.
   - :doc:`/30-objectoriented` — Encapsulation illustrates Information Hiding; trait stacking illustrates Zero-One-Infinity.
   - :doc:`/40-functional` — pure functions illustrate Security and Structure; the type system illustrates Preservation of Information.
