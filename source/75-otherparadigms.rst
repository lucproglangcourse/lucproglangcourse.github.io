Other Important Programming Paradigms
-------------------------------------

In this chapter, we introduce additional programming paradigms that are significant in the field of computer science but have not yet been covered in this book.

Declarative Programming
~~~~~~~~~~~~~~~~~~~~~~~

Declarative programming focuses on what the program should accomplish rather than detailing how to achieve it. SQL and HTML are examples of declarative languages.

**Example (SQL):**

.. code-block:: sql

  SELECT name FROM students WHERE grade > 90;

**Example (HTML):**

.. code-block:: html

  <h1>Hello, world!</h1>

Reactive Programming
~~~~~~~~~~~~~~~~~~~~

Reactive programming is oriented around data streams and the propagation of change. It is commonly used in user interfaces and real-time systems.

**Paradigm-defining language:** RxJS (Reactive Extensions for JavaScript)

**Example (RxJS):**

.. code-block:: javascript

  const clicks = fromEvent(document, 'click');
  clicks.subscribe(() => console.log('Document clicked!'));

Aspect-Oriented Programming
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Aspect-oriented programming (AOP) aims to increase modularity by allowing the separation of cross-cutting concerns, such as logging or security.

**Paradigm-defining language:** AspectJ

**Example (AspectJ):**

.. code-block:: java

  aspect LoggingAspect {
     before(): execution(* MyClass.myMethod(..)) {
        System.out.println("Method called!");
     }
  }

Dataflow Programming
~~~~~~~~~~~~~~~~~~~~

Dataflow programming models programs as a directed graph of the data flowing between operations, making it suitable for parallel and distributed computing.

**Paradigm-defining language:** LabVIEW, TensorFlow

**Example (TensorFlow, Python):**

.. code-block:: python

  import tensorflow as tf
  a = tf.constant(2)
  b = tf.constant(3)
  c = a + b  # Data flows from a and b to c

Other Paradigms
~~~~~~~~~~~~~~~

There are several other paradigms, such as constraint programming, event-driven programming, and more, each with its own unique approach and use cases.

**Constraint Programming (Prolog):**

.. code-block:: prolog

  likes(mary, pizza).
  likes(john, pizza).
  likes(john, wine).

**Event-driven Programming (JavaScript):**

.. code-block:: javascript

  button.addEventListener('click', () => alert('Button clicked!'));
