Introduction to Concurrency
---------------------------


.. todo:: add relevant content from CDER chapter


- concurrency overview and foundations
  - why and when concurrency?
    - when it is a natural fit for the problem domain
      - multiple autonomous behaviors/simulations
      - user interfaces: timed events, background activities
    - when the technical solution domain requires it
      - more efficient use of available resources: asynchronous computing
      - graphical user interfaces: queuing of low-level input events
      - multi-core systems
      - network services/distributed systems
  - fundamentals of concurrency
    - physical (parallelism) versus logical concurrency
    - speedup and when to expect it




# Lecture

## fundamentals of concurrency

  - physical (parallelism) versus logical concurrency
  - speedup and when to expect it
  - data parallelism versus task parallelism

## activity terminology and concerns

  - process: own memory
  - thread: shared memory
  - foreground versus background
  - CPU-bound [example](https://gist.github.com/klaeufer/5409687) versus IO-bound [example](https://gist.github.com/klaeufer/5409800)
  - run-to-completion versus coordination
  - progress reporting
  - cancelation

## projects

- [project 4](https://trello.com/c/KTUBorWF/78-project-4)
- project 3c clinic

# Presentation

According to this https://trello.com/c/a7vQg3qp/54-presentation-schedule. 


  
  
## thread safety

  - nondeterminism [example](https://gist.github.com/klaeufer/5409800)
    - extent of nondeterminism: see [CDER chapter](https://docs.google.com/document/d/1QbPEApea_spbemqluf7xPyaTEf_b2ZQYdBNMeiEOHuw)
  - race conditions [example](https://gist.github.com/klaeufer/5409867)
  - root cause of thread safety problems

## dealing with shared state

  - mutual exclusion/locking
  - confinement
  - immutability
  - case study: GUIs and the single-threaded rule

## (conflicting) design forces

  - correctness/(thread-)safety
  - liveness/deadlock
    - dining philosophers [example](http://www.doc.ic.ac.uk/~jnm/book/book_applets/Diners.html) <- *run on Firefox or Safari with site added to Java security settings*
  - fairness/starvation
  - performance
    - throughput
    - latency
    - jitter

## specific concurrency mechanisms

language constructs, patterns, building blocks

  - threads (familiar from 313/413)
  - monitors: synchronized/locks, wait/notify
  - fully synchronized object (pattern/building blocks)
  - Android
    - [AsyncTask](http://developer.android.com/reference/android/os/AsyncTask.html)
    - [ThreadPoolExecutor](http://developer.android.com/reference/java/util/concurrent/ThreadPoolExecutor.html)
  - [java.util.concurrent](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/package-summary.html)
    - atomic variables
    - thread-safe collections
    - FIFO locks
    - ...
  - [Scala parallel collections](http://docs.scala-lang.org/overviews/parallel-collections/overview.html)
  - [futures and promises intro](http://docs.scala-lang.org/overviews/core/futures.html)
  - [composable futures in Scala/Akka](http://doc.akka.io/docs/akka/current/scala/futures.html)
  - [example: concurrent web requests](https://gist.github.com/klaeufer/3d6a15837bae8d7d5dd07ad9f0db9b97)
  - [actors](https://en.wikipedia.org/wiki/Actor_model)
  - [reactive streams](http://www.reactive-streams.org/) - see also [Akka streams](http://doc.akka.io/docs/akka/2.4.4/scala/stream)
  - [software transactional memory](https://en.wikipedia.org/wiki/Software_transactional_memory)

## projects

- [project 4](https://trello.com/c/KTUBorWF/78-project-4)
- project 3c and 4 clinic

# Presentation

According to this https://trello.com/c/a7vQg3qp/54-presentation-schedule. 



# References

Concurrent and asynchronous computing

- Läufer and Thiruvathukal, [CDER chapter](https://docs.google.com/document/d/1QbPEApea_spbemqluf7xPyaTEf_b2ZQYdBNMeiEOHuw) (especially the section on fundamentals of thread safety)
- Goetz et al., [JCIP](http://jcip.net.s3-website-us-east-1.amazonaws.com/)
- Doug Lea, [CPJ](http://gee.cs.oswego.edu/dl/cpj)
- Thiruvathukal and Christopher, [HPJPC](https://code.google.com/p/hpjpc/)
- [SE Radio episode on concurrency: part 1](http://feedproxy.google.com/~r/se-radio/~3/lJLihLsyf0M/)
- [SE Radio episode on concurrency: part 2](http://feedproxy.google.com/~r/se-radio/~3/Wh7E6YT1_JI/)
- [SE Radio episode on concurrency: part 3](http://feedproxy.google.com/~r/se-radio/~3/WZ7h3kzRARY/)
- [SE Radio episode on concurrency: part 4](http://feedproxy.google.com/~r/se-radio/~3/bqICWnvwuGw/)
- [futures and promises overview](http://arild.github.io/scala-workshop/#/12)
- [RxJava/RxScala](https://github.com/ReactiveX/RxScala)
- [asynchronous programming video](https://www.youtube.com/watch?v=UKjcJ13bD3s)
- [reactive/asynchronous programming with RxJava/RxScala video](https://www.youtube.com/watch?v=_t06LRX0DV0)

