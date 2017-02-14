Appendix: Course Software
-------------------------

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

- Use your GitHub, Visual Studio Team Services, or Google+ account to log into `Codenvy <https://codenvy.io>`_.
- If you do not have any of these accounts, create a `GitHub <https://github.com>`_ account. Please see below for more information on GitHub.

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
- `Git <http://git-scm.com/>`_ distributed version control system (usually preinstalled on Mac OS and Linux)

  - recommended installation option on Windows: *Use Git and optional Unix tools from the Windows Command Prompt*

- `sbt <http://www.scala-sbt.org/0.13/docs/Setup.html>`_ Scala build tool
- `IntelliJ IDEA CE <https://www.jetbrains.com/idea/download/>`_ integrated development environment

  - check specific prerequisite details for your platform
  - for the following steps, make sure you have no projects open and are looking at the welcome window as in the attached screenshot
  - *Scala plugin installation:* IntelliJ IDEA > Configure (bottom right) > Plugins > Browse repositories > find and right-click Scala > download and install > close repository browser > OK to restart IDEA
  - *JDK configuration*: IntelliJ IDEA > Configure > Project Defaults > Project Structure > Platform Settings > SDKs > + > JDK > navigate to the installation directory of your most recent JDK > OK

    
Optional for Windows users
``````````````````````````

- `TortoiseGit <https://code.google.com/p/tortoisegit/>`_ integration of Git with Windows Explorer
- `SourceTree <https://www.sourcetreeapp.com/>`_ Git client

  
Optional for Mac users
``````````````````````

- `SourceTree <https://www.sourcetreeapp.com/>`_ Git client


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
- `sbt-scalariform <https://github.com/sbt/sbt-scalariform>`_: automatic source code formatting using Scalariform (see also `this Gist <https://gist.github.com/klaeufer/8981fcdebc8573b06f3d611d049839d3>`_)
- `sbt-native-packager <https://github.com/sbt/sbt-native-packager>`_: creates a script for running your app outside sbt 
- `ls-sbt <https://github.com/softprops/ls>`_:  browse available libraries on GitHub using ls.implicit.ly
- `sbt-dependency-graph <https://github.com/jrudolph/sbt-dependency-graph>`_: creates a visual representation of library dependency tree
- `cpd4sbt <https://github.com/sbt/cpd4sbt>`_: copy/paste detection for Scala
- `scalastyle <https://github.com/scalastyle/scalastyle-sbt-plugin>`_: static code checker for Scala
- `wart remover <https://github.com/wartremover/wartremover>`_: code linting tool (another static checker)
- `sbt-stats <https://github.com/orrsella/sbt-stats>`_: simple, extensible source code statistics/metrics


Bitbucket 
~~~~~~~~~

`Bitbucket <https://bitbucket.org>`_ is a provider of hosted Git repositories. We use it for project submission and collaboration on team projects.

- Create an account on if you do not yet have one.
- To get upgraded to the top plan for free, associate your account with your official LUC email address.
- Use `this excellent documentation <https://confluence.atlassian.com/bitbucket/set-up-ssh-for-git-728138079.html>`_ to set up public key authentication for your environment. This will allow you to use Git on the command line without having to enter your password.

  
GitHub (optional/recommended)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`GitHub <https://github.com>`_ is another provider of hosted Git repositories, which emphasizes community and collaboration. For this reason, we use it to host our course examples.

- Create a GitHub account if you don't already have one.
- Find and follow a few practitioners you respect. For example, I follow `these developers <https://github.com/klaeufer/following>`_. You'll probably recognize a number of them.
- Review `these notes <https://guides.github.com/activities/contributing-to-open-source>`_ to understand the community-based development process.
- For credit toward class participation, create some meaningful `GitHub issues <https://guides.github.com/features/issues>`_ and/or `GitHub pull requests <https://help.github.com/articles/using-pull-requests>`_ for one or more of our `course examples <https://github.com/lucproglangcourse>`_. (Make sure to navigate to the original repos as these forks do not have their own issue trackers). These can be functional or nonfunctional enhancements, requests for clarification, etc.
- To enhance your visibility in the professional community, start doing the same for some open-source projects you are interested in.
- Consider getting the `GitHub Student Developer Pack <https://education.github.com/pack>`_, which includes µ account with five private repos.

  
Remote participation
~~~~~~~~~~~~~~~~~~~~

For participating in class remotely in case of weather emergencies, install this software:

- `Adobe Connect <http://luc.edu/digitalmedia/trainingandsupport/adobeconnect/about.shtml>`_ 
