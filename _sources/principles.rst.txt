Programming Language Design Principles
--------------------------------------

This is the list of programming language design principles from Bruce MacLennan's excellent Principles of Programming Languages (2nd edition, 1986, ISBN 0-03-005163-0, found on `Oliver Wyman's blog <http://www.lshift.net/blog/2006/06/24/bruce-j-maclennans-programming-language-design-principles>`_.

* **Abstraction**: Avoid requiring something to be stated more than once; factor out the recurring pattern.
* **Automation**: Automate mechanical, tedious, or error-prone activities.
* **Defense in Depth**: Have a series of defences so that if an error isn’t caught by one, it will probably be caught by another.
* **Information Hiding**: The language should permit modules designed so that (1) the user has all of the information needed to use the module correctly, and nothing more; and (2) the implementor has all of the information needed to implement the module correctly, and nothing more.
* **Labeling**: Avoid arbitrary sequences more than a few items long. Do not require the user to know the absolute position of an item in a list. Instead, associate a meaningful label with each item and allow the items to occur in any order.
* **Localized Cost**: Users should only pay for what they use; avoid distributed costs.
* **Manifest Interface**: All interfaces should be apparent (manifest) in the syntax.
* **Orthogonality**: Independent functions should be controlled by independent mechanisms.
* **Portability**: Avoid features or facilities that are dependent on a particular machine or a small class of machines.
* **Preservation of Information**: The language should allow the representation of information that the user might know and that the compiler might need.
* **Regularity**: Regular rules, without exceptions, are easier to learn, use, describe, and implement.
* **Security**: No program that violates the definition of the language, or its own intended structure, should escape detection.
* **Simplicity**: A language should be as simple as possible. There should be a minimum number of concepts, with simple rules for their combination.
* **Structure**: The static structure of the program should correspond in a simple way to the dynamic structure of the corresponding computations.
* **Syntactic Consistency**: Similar things should look similar; different things different.
* **Zero-One-Infinity**: The only reasonable numbers are zero, one, and infinity.
