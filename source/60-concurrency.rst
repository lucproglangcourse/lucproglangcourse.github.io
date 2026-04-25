The Concurrent Programming Paradigm
-----------------------------------

In this chapter, we introduce the concurrent programming paradigm, which allows multiple computations to occur simultaneously or in overlapping time periods. This is particularly useful for applications that require responsiveness, such as user interfaces, or for leveraging multi-core processors to improve performance.


Core Elements
~~~~~~~~~~~~~

The concurrent paradigm is characterized by **multiple sequences of execution 
(progressing independently, potentially interacting with each other)**.  
Concurrency allows programs to handle multiple tasks at once, overlap computation 
with I/O, and exploit multicore architectures.


Threads and Shared Memory
````````````````````````````````

- **Threads** represent independent flows of control within a program.
- Multiple threads share memory; synchronization mechanisms (locks, mutexes, 
  condition variables) ensure consistency.

Synchronization
````````````````````````````````

- Mechanisms such as **mutexes, semaphores, barriers, and monitors** coordinate 
  access to shared resources.
- Avoids race conditions, deadlocks, and data corruption.

Message Passing
```````````````````````````````

- Concurrency via communication rather than shared state.
- Examples: channels (Rust), actors (Scala Akka), message queues.

Futures and Promises
````````````````````````````````

- Abstractions for values that may not yet be available.
- Simplify asynchronous programming by representing results of concurrent tasks.

Data Parallelism
````````````````````````````````

- Operations automatically distributed over data structures.
- Examples: Java parallel streams, Scala parallel collections.

Actors and Reactive Models
````````````````````````````````

- Concurrency modeled as independent **actors** that process messages sequentially.
- Strong isolation; avoids shared state issues.

Examples Across Languages
````````````````````````````````

.. list-table::
   :header-rows: 1
   :widths: 20 20 20 20 20

   * - Element
     - C/C++ (pthreads)
     - Java
     - Scala
     - Rust
   * - Thread creation
     - ``pthread_create(&tid, NULL, f, arg);``
     - ``new Thread(() -> f()).start();``
     - ``new Thread(() => f()).start()`` or ``Future { f() }``
     - ``thread::spawn(|| f());``
   * - Mutex / lock
     - ``pthread_mutex_lock(&m); ... pthread_mutex_unlock(&m);``
     - ``synchronized(obj) { ... }``
     - ``lock.synchronized { ... }``
     - ``let m = Mutex::new(...);`` with ``m.lock()`` 
   * - Condition variable
     - ``pthread_cond_wait(&cv, &m);``
     - ``wait() / notify()`` on objects
     - ``Await.result(future, timeout)``
     - ``Condvar::wait(&mut guard)`` 
   * - Message passing
     - Not built-in (libraries required)
     - ``BlockingQueue.put(msg)``
     - ``actor ! msg`` (Akka)
     - ``let (tx, rx) = mpsc::channel(); tx.send(msg);`` 
   * - Futures / promises
     - Not built-in
     - ``CompletableFuture.supplyAsync(f)``
     - ``val f = Future { compute }``
     - ``let f = async { compute().await };`` 
   * - Data parallelism
     - OpenMP or TBB (library-based)
     - ``list.parallelStream().map(...)``
     - ``List(...).par.map(...)``
     - ``vec.par_iter().map(...)`` (with Rayon crate)
   * - Actors
     - Not standard
     - Akka-like libraries available
     - ``import akka.actor._`` (full actor model)
     - External crates (e.g., Actix)

Discussion
````````````````````````````````

Concurrency is **not a single technique**, but a family of approaches to 
overlapping computations.  

- Low-level threads and locks offer flexibility but require careful handling of 
  synchronization.  
- Higher-level abstractions (futures, parallel collections, actors) increase 
  safety and expressiveness.  
- Languages like Rust enforce memory safety and data-race freedom at compile time, 
  while Scala and Java provide rich libraries for structured concurrency.  
- Choosing the right model depends on the problem: message-passing (actors, channels) 
  suits distributed and reactive systems; data parallelism suits numerical workloads.


Concurrency vs. Parallelism
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although often used interchangeably, **concurrency** and **parallelism** are 
related but distinct concepts in programming.

Concurrency
````````````

- **Definition**: Structuring a program as multiple tasks that can make progress 
  independently.  
- Emphasis: *Dealing with many things at once* (logical composition).  
- A concurrent system may run on a single processor by interleaving tasks 
  (time slicing), or on multiple processors.  
- **Example**:
  
  - A web server that handles thousands of client requests by overlapping 
    network I/O with computation.
  - Java: ``CompletableFuture.supplyAsync(...)`` to launch asynchronous tasks.
  - Scala: ``Future { compute }`` with callback composition.
  - Rust: ``async fn handler() { ... }`` executed on an async runtime.
  - C/C++: cooperative scheduling or event loops layered on top of pthreads.

Parallelism
````````````

- **Definition**: Using multiple processing units (cores, processors, machines) 
  to perform computations simultaneously.  
- Emphasis: *Doing many things at the same time* (physical execution).  
- A parallel system requires hardware support for multiple execution units.  
- **Example**:
  
  - A numerical algorithm that splits an array into parts and processes each 
    part simultaneously.  
  - Java: ``list.parallelStream().map(...)`` distributes work across cores.  
  - Scala: ``List(...).par.map(...)`` uses parallel collections.  
  - Rust: ``vec.par_iter().map(...)`` with the Rayon library.  
  - C/C++: OpenMP pragmas (``#pragma omp parallel for``) for loop parallelism.

Key Distinctions
````````````````

.. list-table::
   :header-rows: 1
   :widths: 25 35 35

   * - Aspect
     - Concurrency
     - Parallelism
   * - Primary goal
     - Handle multiple tasks logically at once
     - Speed up execution using multiple cores
   * - Hardware requirement
     - Not required (can be simulated on a single CPU)
     - Requires multiple cores/CPUs or distributed systems
   * - Typical mechanisms
     - Threads, async/await, actors, channels
     - Data parallel loops, SIMD, GPU kernels
   * - Example use case
     - Web server handling requests
     - Matrix multiplication or image processing


.. raw:: html

   <svg xmlns="http://www.w3.org/2000/svg" width="600" height="150" font-family="sans-serif" font-size="14">
     <!-- Titles -->
     <text x="150" y="20" text-anchor="middle" font-weight="bold" fill="currentColor">Concurrency (Interleaving)</text>
     <text x="450" y="20" text-anchor="middle" font-weight="bold" fill="currentColor">Parallelism (Simultaneous)</text>

     <!-- Concurrency timeline -->
     <line x1="50" y1="60" x2="250" y2="60" stroke="currentColor" />
     <line x1="50" y1="100" x2="250" y2="100" stroke="currentColor" />
     <text x="40" y="65" text-anchor="end" fill="currentColor">Task A</text>
     <text x="40" y="105" text-anchor="end" fill="currentColor">Task B</text>

     <!-- Interleaved blocks -->
     <rect x="50" y="50" width="40" height="20" fill="#ff9999" stroke="currentColor"/>
     <rect x="90" y="90" width="40" height="20" fill="#9999ff" stroke="currentColor"/>
     <rect x="130" y="50" width="40" height="20" fill="#ff9999" stroke="currentColor"/>
     <rect x="170" y="90" width="40" height="20" fill="#9999ff" stroke="currentColor"/>
     <rect x="210" y="50" width="40" height="20" fill="#ff9999" stroke="currentColor"/>

     <!-- Parallelism timelines -->
     <line x1="350" y1="60" x2="550" y2="60" stroke="currentColor" />
     <line x1="350" y1="100" x2="550" y2="100" stroke="currentColor" />
     <text x="340" y="65" text-anchor="end" fill="currentColor">Task A</text>
     <text x="340" y="105" text-anchor="end" fill="currentColor">Task B</text>

     <!-- Simultaneous blocks -->
     <rect x="350" y="50" width="200" height="20" fill="#ff9999" stroke="currentColor"/>
     <rect x="350" y="90" width="200" height="20" fill="#9999ff" stroke="currentColor"/>

     <!-- Labels -->
     <text x="150" y="140" text-anchor="middle" fill="currentColor">One core, time-sliced</text>
     <text x="450" y="140" text-anchor="middle" fill="currentColor">Multiple cores, true overlap</text>
   </svg>



Discussion
````````````

- Concurrency is about **structure**: decomposing programs into independent 
  activities that can interleave.  
- Parallelism is about **execution**: exploiting hardware resources to 
  perform computations faster.  
- Many modern systems combine both:  
  a concurrent web server (handling many connections) uses parallelism 
  internally to process requests across CPU cores.




Motivation
~~~~~~~~~~

Why and when do we need concurrency?

- When it is a natural fit for the problem domain

  - multiple autonomous behaviors/simulations
  - user interfaces: timed events, background activities

- When the technical solution domain requires it

  - more efficient use of available resources: asynchronous computing
  - graphical user interfaces: queuing of low-level input events
  - multi-core systems
  - network services/distributed systems


These are some key concurrency considerations:

- physical (parallelism) versus logical concurrency
- speedup and when to expect it
- data parallelism versus task parallelism
- fine-grained versus coarse-grained concurrency


Fine-grained vs. Coarse-grained Concurrency
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A useful organizing principle for concurrent systems—discussed by C.A.R. Hoare in the context of communicating sequential processes—is the granularity of the concurrent activities:

**Fine-grained concurrency**
  Multiple *threads* within the same process that communicate via *shared memory*.
  Threads are lightweight (low overhead to create and switch), but coordinating shared memory requires careful synchronization (locks, mutexes, atomic variables) to avoid race conditions and deadlocks.

  Typical use cases: parallel computation over in-memory data structures, GUI event loops, concurrent server request handling within a single JVM process.

**Coarse-grained concurrency**
  Multiple *processes*, each with its own private address space, that communicate via *inter-process communication (IPC)* mechanisms or shared external resources (databases, message queues, file systems, network sockets).
  Processes are more isolated and fault-tolerant, but coordination is more expensive.

  Typical use cases: microservices, shell pipelines, distributed systems, producer-consumer architectures built on message queues.

.. list-table:: Fine-grained vs. Coarse-grained Concurrency
   :header-rows: 1
   :widths: 25 35 35

   * -
     - Fine-grained
     - Coarse-grained
   * - Unit of concurrency
     - Thread
     - Process
   * - Communication
     - Shared memory
     - IPC, message queues, shared external resources
   * - Isolation
     - Low (shared address space)
     - High (separate address spaces)
   * - Overhead
     - Low
     - Higher
   * - Failure isolation
     - Weak (a crash affects the whole process)
     - Strong (a crashed process does not affect others)
   * - Scala/JVM examples
     - ``Thread``, ``Future``, ``synchronized``
     - shell pipelines, Akka remote actors, microservices

In practice, most systems combine both granularities: a microservice (coarse-grained) may itself use a thread pool internally (fine-grained).


Activity terminology and concerns
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We distinguish several related concepts:

- process: own memory
- thread: shared memory *and* "thread-local" state
- foreground versus background
- CPU-bound versus IO-bound

  - `CPU-bound example <https://gist.github.com/klaeufer/5409687>`_
  - `IO-bound example <https://gist.github.com/klaeufer/5409800>`_

- run-to-completion versus coordination
- progress reporting
- cancelation


Thread safety
~~~~~~~~~~~~~

Thread safety is a property of code that guarantees safe execution by multiple threads at the same time. This is particularly important when threads share mutable state.


- nondeterminism

  - `example <https://gist.github.com/klaeufer/5409800>`_

- extent of nondeterminism: see subsection below
- race conditions

  - `example <https://gist.github.com/klaeufer/5409867>`_

- root cause of thread safety problems


Understanding the extent of nondeterminism
``````````````````````````````````````````

Consider this small example of two concurrent increment operations::

  /*f1*/ final int local1 = shared;    /*f2*/ final int local2 = shared;
  /*s1*/ shared = local1 + 1;          /*s2*/ shared = local2 + 1;


When analyzing race conditions, we might be tempted to enumerate the different possible interleavings.
While it seems reasonable for this example, this quickly becomes impractical because of the combinatorial explosion for larger number of threads with more steps. (Please see the CDER chapter for more details.)

To appreciate this combinatorial explosion, let’s count the possible interleavings for the case of :math:`k` threads with :math:`n` steps each. We recall the binomial coefficient :math:`i` choose :math:`j` defined as

.. math::

   \binom{i}{j} = \frac{i!}{j!(i-j)!} \text{ for } 0 \leq j \leq i


In our case, there are :math:`kn` steps, of which the first thread chooses :math:`n`; there are :math:`\binom{kn}{n}` possibilities for this.
This leaves :math:`(k-1)n` steps, of which the second thread chooses :math:`n`, and so on.
At the end, there are :math:`n` steps left, which are the only choice for the last thread.
The total number of choices is the product of choices for each thread:

.. math::

  \binom{kn}{n} \binom{(k-1)n}{n} \dots \binom{2n}{n} \binom{n}{n} =
  \frac{(kn)!}{n!(kn-n)!} \frac{((k-1)n)!}{n!((k-1)n-n)!} \dots \frac{(2n)!}{n!(2n-n)!} \frac{(n)!}{n!(n-n)!}


Here the second factor in each denominator cancels out against the numerator of the next top-level factor and the second factor in the last denominator is :math:`1`, leaving

.. math::

  \frac{(kn)!}{{n!}^k}


As the number of threads and/or their number of steps grow beyond two, the number interleavings gets very large.

.. math::

  \begin{matrix}
  n / k  & k = 2 & k = 3 & k = 4 \\
  n = 2 & 6  & 90 & 2520 \\
  n = 3 & 20 & 1680 & 369600 \\
  n = 4 & 70 & 34650 & 63063000
  \end{matrix}


Therefore, we cannot attempt to comprehend, let alone enumerate, all possible interleavings. Instead, we need to think in terms of constraints, e.g., f1 always happens before s1, and f2 always happens before s2.

This combinatorial explosion is known as the *state-space explosion problem* — the fundamental reason that exhaustive testing of concurrent programs is infeasible even for small numbers of threads and steps. It motivates the use of *model checking* tools (such as TLA+, SPIN, or Java Pathfinder) that can systematically explore the state space without exhaustive enumeration, and *type-based approaches* (such as Rust's ownership system) that statically rule out data races.

Once we make each thread atomic, however, the number of interleavings shrinks dramatically to :math:`k!`.



Dealing with shared state
~~~~~~~~~~~~~~~~~~~~~~~~~

One of the main challenges of concurrent programming is dealing with shared mutable state. Several complementary strategies exist:

- **Mutual exclusion (locking)**: protect shared state with a lock so that only one thread accesses it at a time. In Java/Scala, ``synchronized`` blocks or ``java.util.concurrent.locks.ReentrantLock`` provide this guarantee. The risk is *deadlock* if two threads each hold a lock the other needs.

- **Confinement**: ensure that mutable state is never shared between threads in the first place. Thread-local storage (``java.lang.ThreadLocal``) confines data to a single thread. The actor model (see :ref:`specific-concurrency-mechanisms`) achieves confinement at a higher level by giving each actor its own private state.

- **Immutability**: use data structures that cannot be modified after creation. Immutable data can be shared freely between threads without synchronisation. Functional programming's emphasis on immutable values (see :doc:`/40-functional`) is therefore directly beneficial for concurrent programming.

- **Single-threaded rule (GUI applications)**: most GUI frameworks (Android, Swing, JavaFX) require that all UI updates happen on a dedicated *UI thread*. Background work runs on other threads; results are posted back to the UI thread via ``runOnUiThread`` (Android) or ``SwingUtilities.invokeLater`` (Swing). Violating this rule leads to subtle, hard-to-reproduce rendering bugs.


(Conflicting) design forces
~~~~~~~~~~~~~~~~~~~~~~~~~~~

This gives rise to several conflicting design forces:

- correctness/(thread-)safety
- liveness/deadlock

  - `dining philosophers problem <https://en.wikipedia.org/wiki/Dining_philosophers_problem>`_
  - `interactive demo <https://nlp.nd.edu/justin/dining/interactiveExplanation.php>`_
  - `Scala example <https://gist.github.com/klaeufer/39d03158c4b766ce3c1c669f0d8ab930>`_

- fairness/starvation
- performance

  - throughput
  - latency
  - jitter


.. _specific-concurrency-mechanisms:

Specific concurrency mechanisms
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Several specific concurrency mechanisms can come as language constructs, patterns, and other building blocks:

- threads (familiar from 313/413)
- monitors: synchronized/locks, wait/notify
- fully synchronized object (pattern/building blocks)
- Android (also familiar from 313/413)

  - `AsyncTask <https://developer.android.com/reference/android/os/AsyncTask.html>`_ *(deprecated in Android API 30; prefer* `Kotlin coroutines <https://developer.android.com/kotlin/coroutines>`_ *or* `WorkManager <https://developer.android.com/topic/libraries/architecture/workmanager>`_ *)*
  - `ThreadPoolExecutor <https://developer.android.com/reference/java/util/concurrent/ThreadPoolExecutor.html>`_

- `java.util.concurrent <https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/package-summary.html>`_

  - atomic variables
  - thread-safe collections
  - FIFO locks
  - ...

- `Scala parallel collections <https://docs.scala-lang.org/overviews/parallel-collections/overview.html>`_
- `futures and promises intro <https://docs.scala-lang.org/overviews/core/futures.html>`_
- `composable futures in Scala/Akka <https://doc.akka.io/docs/akka/current/scala/futures.html>`_

  .. note:: As of 2022, Akka is under a commercial license (Lightbend). The open-source Scala ecosystem has largely shifted to `Cats Effect <https://typelevel.org/cats-effect/>`_ and `ZIO <https://zio.dev/>`_ for structured concurrency. Both provide safe, composable, and purely functional abstractions for asynchronous and concurrent programming.

  - `example: concurrent web requests <https://gist.github.com/klaeufer/3d6a15837bae8d7d5dd07ad9f0db9b97>`_

- `actors <https://en.wikipedia.org/wiki/Actor_model>`_
- `reactive streams <http://www.reactive-streams.org>`_ including `Akka streams <https://doc.akka.io/libraries/akka-core/current/stream/?language=scala>`_
- `software transactional memory <https://en.wikipedia.org/wiki/Software_transactional_memory>`_


References: concurrent and asynchronous computing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Läufer and Thiruvathukal, `CDER book chapter <https://arxiv.org/abs/1705.02899>`_
- Goetz et al., `JCIP <http://jcip.net.s3-website-us-east-1.amazonaws.com>`_
- Doug Lea, `CPJ <http://gee.cs.oswego.edu/dl/cpj>`_
- Thiruvathukal and Christopher, `HPJPC <https://code.google.com/p/hpjpc/>`_
- `SE Radio episode 12: Concurrency pt. 1 <https://se-radio.net/2006/04/episode-12-concurrency-pt-1/>`_
- `SE Radio episode 19: Concurrency pt. 2 <https://se-radio.net/2006/06/episode-19-concurrency-pt-2/>`_
- `SE Radio episode 29: Concurrency pt. 3 <https://se-radio.net/2006/09/episode-29-concurrency-pt-3/>`_
- `SE Radio episode 348: Riccardo Terrell on Concurrency <https://se-radio.net/2018/12/se-radio-episode-348-riccardo-terrell-on-concurrency/>`_
- `futures and promises overview <http://arild.github.io/scala-workshop/#/12>`_
- `RxJava/RxScala <https://github.com/ReactiveX/RxScala>`_
- `asynchronous programming video <https://www.youtube.com/watch?v=UKjcJ13bD3s>`_
- `reactive/asynchronous programming with RxJava/RxScala video <https://www.youtube.com/watch?v=_t06LRX0DV0>`_
