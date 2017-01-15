Course Software
---------------


You can choose either or both of the following options.

Cloud-based development environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


This option is recommended if you have any problems with your local setup or if you prefer a basic cloud-based setup.


Pros
````

- consistent, cloud-based environment

Cons
````

- requires good network connection
- lacks code completion


Setup
`````


- Create a `GitHub <https://github.com>`_ account if you don't have one already.
- Use your GitHub account to log into `Codenvy <https://codenvy.io>`_.
- Create a new workspace with the following settings:

  - New from blank ...
  - Create new workspace from stack > BLANK
  - Name: lucproglangcourse
  - RAM: 3GB

- Wait for the workspace to become available. Now you have a persistent, cloud-based, standard Ubuntu/Linux command-line environment that you can work in and come back to from any computer.
- In the resulting Linux terminal, run `this gist <https://gist.github.com/klaeufer/c4040de09f51395b96be/raw>`_ to install the Scala build tool (sbt)::

        wget https://gist.github.com/klaeufer/c4040de09f51395b96be/raw/install-sbt-ubuntu.sh && sh install-sbt-ubuntu.sh

- Now you can check out existing projects using git or create a new one like so::

	$ mkdir -p hello/src/main/scala
	$ cd hello
	$ cat > src/main/scala/Hello.scala
	object Hello extends App {
	  println("hello")
	}
	^D
	$ sbt run
	...
	hello



Locally installed development environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


This option will give you an advanced development environment with code completion, type info, etc.


Pros
````

- provides powerful capabilities, including code completion 
- does not require network connection 

  
Cons
````

- might be slow on older machines
- need to maintain on each machine you use 



Required components
```````````````````

- `Java 8 and/or newer JDK <http://www.oracle.com/technetwork/java/javase/downloads/>`_
- `Git DSCM <http://git-scm.com/>`_ (usually preinstalled on Mac OS and Linux)

  - recommended installation option on Windows: *Use Git and optional Unix tools from the Windows Command Prompt*

- `sbt <http://www.scala-sbt.org/0.13/docs/Setup.html>`_
- `IntelliJ IDEA CE <https://www.jetbrains.com/idea/download/>`_

  - check specific prerequisite details for your platform
  - for the following steps, make sure you have no projects open and are looking at the welcome window as in the attached screenshot
  - *Scala plugin installation:* IntelliJ IDEA > Configure (bottom right) > Plugins > Browse repositories > find and right-click Scala > download and install > close repository browser > OK to restart IDEA
  - *JDK configuration*: IntelliJ IDEA > Configure > Project Defaults > Project Structure > Platform Settings > SDKs > + > JDK > navigate to the installation directory of your most recent JDK > OK

    
Optional for Windows users
``````````````````````````

- `TortoiseGit <https://code.google.com/p/tortoisegit/>`_ (integration of Git with Windows Explorer)
- `SourceTree Git client <https://www.sourcetreeapp.com/>`_

  
Optional for Mac users
``````````````````````

- `SourceTree Git client <https://www.sourcetreeapp.com/>`_


Optional for all IntelliJ users
```````````````````````````````

- These are useful Android Studio/Intellij IDEA plugins. (Installation procedure is the same as for the Scala plugin.)

  - Key Promoter (helps you learn keyboard shortcuts)
  - MultiMarkdown

- IntelliJ IDEA Scala worksheets are a convenient way to do REPL-style exploratory programming while being able to modify and save all your code.

  Check out `this example <https://github.com/lucproglangcourse/misc-explorations-scala>`_, especially the simple option and list examples.

  Worksheets can live in any folder and coexist with other code. So you can start exploring something in a worksheet and then move it into your production code.

  
sbt tips and optional plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section applies to all uses of sbt, whether cloud-based or on the local command line.

In conjunction with a `text editor <https://www.gnu.org/software/emacs>`_, sbt's `triggered execution <http://www.scala-sbt.org/0.13/docs/Triggered-Execution.html>`_ for testing will significantly shorten the edit-compile-run/test cycle.

These are useful additional sbt plugins. `You can install them per project or globally. <http://www.scala-sbt.org/0.13/tutorial/Using-Plugins.html>`_ Some of the example projects already come with one or more of these plugins. 

- `sbt-scoverage <https://github.com/scoverage/sbt-scoverage>`_: uses Scoverage to produce a test code coverage report
- `sbt-updates <https://github.com/rtimush/sbt-updates>`_: checks central repos for dependency updates
- `ls-sbt <https://github.com/softprops/ls>`_:  browse available libraries on GitHub using ls.implicit.ly
- `sbt-dependency-graph <https://github.com/jrudolph/sbt-dependency-graph>`_: creates a visual representation of library dependency tree
- `cpd4sbt <https://github.com/sbt/cpd4sbt>`_: copy/paste detection for Scala
- `scalastyle <https://github.com/scalastyle/scalastyle-sbt-plugin>`_: static code checker for Scala
- `sbt-stats <https://github.com/orrsella/sbt-stats>`_: simple, extensible source code statistics/metrics
- `sbt-scalariform <https://github.com/sbt/sbt-scalariform>`_: automatic source code formatting using Scalariform

    
Required for remote participation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- `Adobe Connect <http://luc.edu/digitalmedia/trainingandsupport/adobeconnect/about.shtml>`_ for holding class remotely in case of weather emergencies
