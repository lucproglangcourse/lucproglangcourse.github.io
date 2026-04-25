.. _appendix-software:

Appendix: Course Software
-------------------------

You can choose either or both of the following options.


Cloud-based development environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This option is recommended if you have any problems with your local setup or if you prefer a basic cloud-based setup.


Pros
````

- consistent, cloud-based environment
- out-of-the-box integration with GitHub


Cons
````

- requires good network connection
- might lack some code completion features
- free plan might be underresourced (CPUs, RAM, disk space, etc.)
- lack of integration with external GUI-based tools
- won't support GUI or mobile development out of the box


Zero-install option: Scastie
````````````````````````````

Scastie is an interactive playground for Scala with support for Scala 3 and sbt (Scala Build Tool) configuration.
It allows you to save code snippets to your GitHub account, which you can access later.
It is not suitable for working on full-fledged Scala projects, however.

To launch, visit https://scastie.scala-lang.org.
Be sure to

- choose target Scala 3 and the latest available Scala 3 LTS version (Scastie's version list is updated regularly; always choose the most recent 3.x LTS entry)
- add the following `scalacOptions` under build settings::

    "-Yexplicit-nulls",
    "-language:strictEquality"


GitHub Codespaces (recommended)
"""""""""""""""""""""""""""""""

GitHub Codespaces is a cloud-based, containerized development environment based on Visual Studio Code running on Ubuntu LTS and closely integrated with GitHub.

To use Codespaces, 

- Log into using your GitHub account and navigate to the desired repository.
- Look for the blue "code" button and open the drop-down menu.
- Select the Codespaces tab.
- Create a new Codespace for this repo or open an existing one already linked to this repo.
- You can also find your existing codespaces at https://github.com/codespaces.

For more information, please refer to `this reference <https://docs.github.com/en/codespaces>`_.

For Scala development with Codespaces,

- For each new codespace, using the installed `SDKMAN! <https://sdkman.io>`_, perform a one-time installation of `sbt <https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html>`_
  (unless the project is already configured to perform these steps automatically).
- The VS Code Scala and Metals extensions seem to get installed automatically; otherwise you can install them manually along with any other desired extensions.
- Now you should be able to work on the project by using the hamburger menu in the top left corner to open a terminal and following the instructions in the included README.
- Sometimes Codespaces loses changes made to the workspace itself, such as installing packages via ``sdk``. 
  For example, it might no longer find ``sbt``.
  In these cases, simply rerun ``sdk install sbt`` and ``sdk install java``.
- The `Live Preview <https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server>`_ extension is recommended for opening HTML files directly within Codespaces.


Locally installed development environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This option will give you an advanced development environment with code completion, type info, etc.


Pros
````

- provides powerful capabilities, including code completion
- does not require network connection once installed


Cons
````

- might be slow on older machines
- need to maintain on each machine you use
- it can be challenging to match the versions of the various packages


Required packages
`````````````````

- `Java 21 or newer JDK (LTS release recommended) <http://www.oracle.com/technetwork/java/javase/downloads/>`_
- `Git <http://git-scm.com/>`_ distributed version control system (usually preinstalled on Mac OS and Linux)

  - recommended installation option on Windows: *Use Git and optional UNIX tools from the Windows Command Prompt*
  - optional on any platform, especially when not using IntelliJ IDEA: `some GUI-based Git client <https://git-scm.com/downloads/guis>`_


- `sbt <https://www.scala-sbt.org/1.x/docs/Setup.html>`_ Scala build tool
- `VisualVM <https://visualvm.github.io/>`_ visual heap profiling tool
- *Mac and Linux users are strongly encouraged to use* `SDKMAN! <https://sdkman.io/>`_ *to manage their Java, sbt, VisualVM, and other command-line development tools.*
- Windows users are strongly encouraged to use `WSL <https://docs.microsoft.com/en-us/windows/wsl/install>`_ (Windows Subsystem for Linux) to run a Linux environment on their Windows machines and then install SDKMAN! and the other command-line tools there.


Choices of development environments
```````````````````````````````````

- `IntelliJ IDEA CE <https://www.jetbrains.com/idea/download/>`_ integrated development environment (recommended)

  - check specific prerequisite details for your platform
  - for the following steps, make sure you have no projects open and are looking at the welcome window as in the attached screenshot
  - *Scala plugin installation (current IntelliJ IDEA):* Go to **File > Settings** (Windows/Linux) or **IntelliJ IDEA > Preferences** (macOS), open the **Plugins** tab, search for "Scala" in the **Marketplace**, click **Install**, and restart IntelliJ IDEA. Alternatively, IntelliJ IDEA will automatically prompt you to install the Scala plugin when you first open a ``.scala`` or ``build.sbt`` file.
  - *JDK configuration*: IntelliJ IDEA > Configure > Project Defaults > Project Structure > Platform Settings > SDKs > + > JDK > navigate to the installation directory of your most recent JDK > OK

- `Visual Studio Code <https://code.visualstudio.com/>`_ alternative based on your preference and/or experience

  - it should offer to install Scala support when you open a Scala project folder for the first time
  - `discussion of IDEA vs VS Code for Scala development <https://stackoverflow.com/a/61156424>`_

- conventional text editor

  - Emacs
  - vim
  - etc.


sbt optional plugins
~~~~~~~~~~~~~~~~~~~~

This section applies to all uses of sbt, whether cloud-based or on the local command line.

These are useful additional sbt plugins. `You can install them per project or globally. <http://www.scala-sbt.org/0.13/tutorial/Using-Plugins.html>`_ Many of the example projects already come with one or more of these plugins (especially the first two).

- `sbt-native-packager <https://github.com/sbt/sbt-native-packager>`_: creates a script for running your app outside sbt
- `sbt-scoverage <https://github.com/scoverage/sbt-scoverage>`_: uses Scoverage to produce a test code coverage report
- `sbt-updates <https://github.com/rtimush/sbt-updates>`_: checks central repos for dependency updates
- `sbt-scalafmt <https://github.com/scalameta/sbt-scalafmt>`_: automatic source code formatting using `Scalafmt <https://scalameta.org/scalafmt/>`_
- `scalastyle <https://github.com/scalastyle/scalastyle-sbt-plugin>`_: static code checker for Scala
- `wart remover <https://github.com/wartremover/wartremover>`_: code linting tool (another static checker)


GitHub
~~~~~~

`GitHub <https://github.com>`_ is a provider of hosted Git repositories, which emphasizes community and collaboration. For this reason, we use it to host our course examples.

- Create a GitHub account if you don't already have one.
- Get the `GitHub Student Developer Pack <https://education.github.com/pack/join>`_ using your official ``@luc.edu`` address. This gives you access to GitHub Copilot (free for verified students), additional CI/CD minutes, and a range of third-party developer tools at no cost. See the `current benefit list <https://education.github.com/pack>`_ for up-to-date details, as benefits change regularly.
- Find and follow a few practitioners you respect. For example, I follow `these developers <https://github.com/klaeufer?tab=following>`_. You'll probably recognize a number of them.
- Review `these notes <https://guides.github.com/activities/contributing-to-open-source>`_ to understand the community-based development process.
- For credit toward class participation, create some meaningful `GitHub issues <https://guides.github.com/features/issues>`_ and/or `GitHub pull requests <https://help.github.com/articles/using-pull-requests>`_ for one or more of our `course examples <https://github.com/lucproglangcourse>`_. (Make sure to navigate to the original repos as these forks do not have their own issue trackers). These can be functional or nonfunctional enhancements, requests for clarification, etc.
- To enhance your visibility in the professional community, start doing the same for some open-source projects you are interested in.

You may find both of these cheat sheets useful:

- `GitHub <https://education.github.com/git-cheat-sheet-education.pdf>`_
- `GitLab <https://about.gitlab.com/images/press/git-cheat-sheet.pdf>`_ (includes useful diagrams)


Remote participation
~~~~~~~~~~~~~~~~~~~~

When class is held remotely (e.g., due to weather emergencies or other circumstances), participation will use the video conferencing tool specified on the course syllabus. Keep that tool updated for security and privacy reasons.


Troubleshooting
~~~~~~~~~~~~~~~

Common setup issues and their solutions:

**sbt not found after reopening a Codespace**
  Codespace workspaces can lose installed packages between sessions. Reinstall with:

  .. code-block:: bash

    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install sbt
    sdk install java 21.0.2-tem  # or whichever version your project requires

**Metals (VS Code Scala extension) not importing the project**
  Delete the Metals and Bloop caches and reimport:

  .. code-block:: bash

    rm -rf .metals/ .bloop/ project/project/ project/target/
    # Then: VS Code command palette → Metals: Import build

**Java version mismatch**
  Check that ``java -version`` matches the Java version expected by your ``build.sbt``. If not:

  .. code-block:: bash

    sdk list java          # see available versions
    sdk use java 21.0.2-tem

**sbt downloads dependencies slowly on first run**
  This is normal: sbt resolves and downloads all project dependencies from Maven Central on the first build. Subsequent builds use a local cache (``~/.ivy2`` and ``~/.sbt``).
