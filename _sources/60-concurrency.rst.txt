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

Once we make each thread atomic, however, the number of interleavings shrinks dramatically to :math:`k!`.



Dealing with shared state
~~~~~~~~~~~~~~~~~~~~~~~~~

One of the main challenges of concurrent programming is dealing with shared mutable state. Several strategies exist:

- mutual exclusion/locking
- confinement
- immutability
- case study: GUIs and the single-threaded rule


(Conflicting) design forces
~~~~~~~~~~~~~~~~~~~~~~~~~~~

This gives rise to several conflicting design forces:

- correctness/(thread-)safety
- liveness/deadlock

  - `dining philosophers example <https://gist.github.com/klaeufer/39d03158c4b766ce3c1c669f0d8ab930>`_

- fairness/starvation
- performance

  - throughput
  - latency
  - jitter


Specific concurrency mechanisms
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Several specific concurrency mechanisms can come as anguage constructs, patterns, and other building blocks:

- threads (familiar from 313/413)
- monitors: synchronized/locks, wait/notify
- fully synchronized object (pattern/building blocks)
- Android (also familiar from 313/413)

  - `AsyncTask <http://developer.android.com/reference/android/os/AsyncTask.html>`_
  - `ThreadPoolExecutor <http://developer.android.com/reference/java/util/concurrent/ThreadPoolExecutor.html>`_

- `java.util.concurrent <https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/package-summary.html>`_

  - atomic variables
  - thread-safe collections
  - FIFO locks
  - ...

- `Scala parallel collections <http://docs.scala-lang.org/overviews/parallel-collections/overview.html>`_
- `futures and promises intro <http://docs.scala-lang.org/overviews/core/futures.html>`_
- `composable futures in Scala/Akka <http://doc.akka.io/docs/akka/current/scala/futures.html>`_

  - `example: concurrent web requests <https://gist.github.com/klaeufer/3d6a15837bae8d7d5dd07ad9f0db9b97>`_

- `actors <https://en.wikipedia.org/wiki/Actor_model>`_
- `reactive streams <http://www.reactive-streams.org>`_ including `Akka streams <http://doc.akka.io/docs/akka/2.4.4/scala/stream>`_
- `software transactional memory <https://en.wikipedia.org/wiki/Software_transactional_memory>`_


References: concurrent and asynchronous computing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Läufer and Thiruvathukal, `CDER book chapter <https://arxiv.org/abs/1705.02899>`_
- Goetz et al., `JCIP <http://jcip.net.s3-website-us-east-1.amazonaws.com>`_
- Doug Lea, `CPJ <http://gee.cs.oswego.edu/dl/cpj>`_
- Thiruvathukal and Christopher, `HPJPC <https://code.google.com/p/hpjpc/>`_
- `SE Radio episode on concurrency: part 1 <http://feedproxy.google.com/~r/se-radio/~3/lJLihLsyf0M/>`_
- `SE Radio episode on concurrency: part 2 <http://feedproxy.google.com/~r/se-radio/~3/Wh7E6YT1_JI/>`_
- `SE Radio episode on concurrency: part 3 <http://feedproxy.google.com/~r/se-radio/~3/WZ7h3kzRARY/>`_
- `SE Radio episode on concurrency: part 4 <http://feedproxy.google.com/~r/se-radio/~3/bqICWnvwuGw/>`_
- `futures and promises overview <http://arild.github.io/scala-workshop/#/12>`_
- `RxJava/RxScala <https://github.com/ReactiveX/RxScala>`_
- `asynchronous programming video <https://www.youtube.com/watch?v=UKjcJ13bD3s>`_
- `reactive/asynchronous programming with RxJava/RxScala video <https://www.youtube.com/watch?v=_t06LRX0DV0>`_
