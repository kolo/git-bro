Git-bro
=======
[Git-bro](http://github.com/kolo/git-bro) is a server for your Git repositories. Git-bro is build on top of {Sinatra}[http://www.sinatrarb.com/] framework.

1) Install the gem with the following command

    sudo gem install git-bro

2) Start serving

    # serve given path
    git-bro serve /path/to/my/git/repository

    # serve current directory
    git-bro serve

3) Open link in browser - [http://localhost:4567](http://localhost:4567)

Usage
-----
Common syntax of command is

    git-bro [--version] [--help] COMMAND [ARGS]

Supported commands:

* serve serve given or current directory

Development
-----------

Sources can be found on [Github](http://github.com/kolo/git-bro).

Authors
-------

* Dmitry Maksimov [http://dmaximov.net](http://dmaximov.net)

Copyright
---------

Copyright (c) 2010 Dmitry Maksimov. See [LICENSE](LICENSE) for details.
