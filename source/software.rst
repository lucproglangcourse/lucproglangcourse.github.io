# Course software

You can choose either or both of the following options.

# Cloud-based development environment

This option is recommended if you have any problems with your local setup.

- create Bitbucket and GitHub accounts (add your official Loyola email address to your Bitbucket account to get the unlimited plan)
- use your Bitbucket or GitHub account to log into [Cloud9](https://c9.io)
- to work on a private Scala project based on an example
  - create a *private fork* of the example in your Bitbucket account
  - create a *private* Cloud9 workspace 
    - clone from the Bitbucket Git URL of your private fork of the example
    - choose the *Custom* template
  - in the resulting Linux terminal, run [this gist](https://gist.github.com/klaeufer/c4040de09f51395b96be) to install the Scala sbt and Java 8

        wget https://gist.github.com/klaeufer/c4040de09f51395b96be/raw/4ba2da21e9b9443bceee5e771e2c42a982ac1db1/install-sbt-and-java8-ubuntu.sh
        sh install-sbt-and-java8-ubuntu.sh

    you will need to navigate through various prompts and accept the Oracle JDK license

- the free plan gives you unlimited public and one private repository  
  - *apparently, one can change public workspaces to private after creating them, though this feature might be considered a bug and might go away*
  - alternatively, if you are comfortable using Git on the command line, you can work on multiple Git projects in your private workspace

# Locally installed development environment

This option will give you an advanced development environment with code completion, type info, etc.

## Required

- [Java 6 and/or newer JDK](http://www.oracle.com/technetwork/java/javase/downloads/) (Java 8 recommended)
- [Git DSCM](http://git-scm.com/)
  - recommended installation option on Windows: *Use Git and optional Unix tools from the Windows Command Prompt*
- [sbt](http://www.scala-sbt.org)
- [IntelliJ IDEA 15.0.4 CE](http://www.jetbrains.com/idea/download/)
  - check specific prerequisite details for your platform
  - for the following steps, make sure you have no projects open and are looking at the welcome window as in the attached screenshot
  - *Scala plugin installation:* IntelliJ IDEA > Configure (bottom right) > Plugins > Browse repositories > find and right-click Scala > download and install > close repository browser > OK to restart IDEA
  - *JDK configuration*: IntelliJ IDEA > Configure > Project Defaults > Project Structure > Platform Settings > SDKs > + > JDK > navigate to the installation directory of your most recent JDK > OK

## Optional for Windows users

- [TortoiseGit](https://code.google.com/p/tortoisegit/) (integration of Git with Windows Explorer)
- [GitHub GUI client](https://windows.github.com)

## Optional for Mac users

- [GitHub GUI client](https://mac.github.com)

## Optional for all IntelliJ users

- These are useful Android Studio/Intellij IDEA plugins. (Installation procedure is the same as for the Scala plugin.)

  - Key Promoter (helps you learn keyboard shortcuts)
  - MultiMarkdown

- IntelliJ IDEA Scala worksheets are a super-convenient way to do REPL-style exploratory programming while being able to modify and save all your code.

  Check out [this example](https://github.com/lucproglangcourse/misc-explorations-scala), especially the simple option and list examples.

  Worksheets can live in any folder and coexist with other code. So you can start exploring something in a worksheet and then move it into your production code.

# Required for remote participation

- [Adobe Connect](http://luc.edu/digitalmedia/trainingandsupport/adobeconnect/about.shtml) for holding class remotely in case of weather emergencies

# Optional for sbt

These are useful additional sbt plugins. [You can install them per project or globally.](http://www.scala-sbt.org/0.13/tutorial/Using-Plugins.html) Some of the example projects already come with one or more of these plugins. 

  - [sbt-scoverage](https://github.com/scoverage/sbt-scoverage): uses Scoverage to produce a test code coverage report
  - [sbt-updates](https://github.com/rtimush/sbt-updates): checks central repos for dependency updates
  - [ls-sbt](https://github.com/softprops/ls):  browse available libraries on GitHub using ls.implicit.ly
  - [sbt-dependency-graph](https://github.com/jrudolph/sbt-dependency-graph): creates a visual representation of library dependency tree
  - [cpd4sbt](https://github.com/sbt/cpd4sbt): copy/paste detection for Scala
  - [scalastyle](https://github.com/scalastyle/scalastyle-sbt-plugin): static code checker for Scala
  - [sbt-stats](https://github.com/orrsella/sbt-stats): simple, extensible source code statistics/metrics
  - [sbt-scalariform](https://github.com/sbt/sbt-scalariform): automatic source code formatting using Scalariform
