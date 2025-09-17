Other Important Programming Paradigms
-------------------------------------

In this chapter, we introduce additional programming paradigms that are significant in the field of computer science but have not yet been covered in this book.

Declarative Programming
~~~~~~~~~~~~~~~~~~~~~~~

Declarative programming focuses on what the program should accomplish rather than detailing how to achieve it. SQL and XML, including HTML, are examples of declarative languages.

- Focus: specify desired results rather than control flow.
- Common uses: configuration, markup, query languages, and transformation languages.
- Strengths: concise, closer to domain concepts, often easier to reason about correctness.
- Weaknesses: can be less explicit about performance or control; tooling/optimization may hide important costs.

**Example: SQL**

SQL is a declarative query language for managing and retrieving data from relational databases.

.. code-block:: sql

  SELECT name FROM students WHERE grade > 90;

**Example: HTML**

HTML is a declarative markup language for structuring and presenting content on the web.

.. code-block:: html

  <h1>Hello, world!</h1>

**Example: XML and XSLT**

XML is a markup language for encoding documents in a format that is both human-readable and machine-readable.
While HTML is a specific instance of XML used for web content, XML itself is more general-purpose and can be used to represent a wide variety of data structures.

XSLT is a declarative language for pattern-driven, template-based transformation of XML documents into other XML, HTML, or text formats. Rather than writing imperative code to walk and manipulate a tree, you describe transformation rules and templates that match parts of the input.

XPath is a language for selecting nodes from an XML document.
It is often used within XSLT to navigate XML structures.

.. code-block:: xml

  <!-- students.xml (example input document) -->
  <?xml version="1.0" encoding="UTF-8"?>
  <students>
    <student id="s001">
      <name>Mary Smith</name>
      <grade>95</grade>
      <major>Computer Science</major>
      <email>mary.smith@example.edu</email>
      <enrolled>2023-09-01</enrolled>
    </student>
    <student id="s002">
      <name>John Doe</name>
      <grade>88</grade>
      <major>Mathematics</major>
      <email>john.doe@example.edu</email>
      <enrolled>2022-09-01</enrolled>
    </student>
    <student id="s003">
      <name>Alice Chen</name>
      <grade>92</grade>
      <major>Physics</major>
      <email>alice.chen@example.edu</email>
      <enrolled>2023-01-15</enrolled>
    </student>
  </students>

  <!-- transform.xslt (example stylesheet for transformation to HTML) -->
  <?xml version="1.0"?>
  <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
      <html>
        <body>
          <h1>Students</h1>
          <ul>
            <xsl:for-each select="students/student[grade &gt; 90]">
              <li><xsl:value-of select="name"/></li>
            </xsl:for-each>
          </ul>
        </body>
      </html>
    </xsl:template>
  </xsl:stylesheet>

Reactive Programming
~~~~~~~~~~~~~~~~~~~~

Reactive programming is oriented around data streams and the propagation of change. It is commonly used in user interfaces and real-time systems.

- Focus: streams of data, event propagation, and change propagation.
- Common uses: UIs, dashboards, real-time analytics, and asynchronous workflows.
- Strengths: models time-varying values naturally, simplifies composition of asynchronous events.
- Weaknesses: mental overhead for reasoning about time and backpressure; debugging can be tricky.

**Paradigm-defining language:** RxJS (Reactive Extensions for JavaScript)

**Example (RxJS):**

.. code-block:: javascript

  const clicks = fromEvent(document, 'click');
  clicks.subscribe(() => console.log('Document clicked!'));

Aspect-Oriented Programming
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Aspect-oriented programming (AOP) aims to increase modularity by allowing the separation of cross-cutting concerns, such as logging or security.

- Focus: separate cross-cutting concerns from core logic via aspects and advice.
- Common uses: logging, security, transaction management, and instrumentation.
- Strengths: keeps core code cleaner; centralized handling of orthogonal concerns.
- Weaknesses: can obscure control flow and make reasoning about behavior harder.

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

- Focus: data dependencies and flow rather than explicit control flow.
- Common uses: signal processing, stream processing, and parallel computation (e.g., TensorFlow graphs).
- Strengths: natural parallelism, clear depiction of dependencies.
- Weaknesses: can be less intuitive for control-heavy logic; graph management can be complex.

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

- Constraint Programming (Prolog): express relations and let the solver find solutions.
- Event-driven Programming (JavaScript): drive computation by events and callbacks.

**Constraint Programming (Prolog):**

.. code-block:: prolog

  likes(mary, pizza).
  likes(john, pizza).
  likes(john, wine).

**Event-driven Programming (JavaScript):**

.. code-block:: javascript

  button.addEventListener('click', () => alert('Button clicked!'));
