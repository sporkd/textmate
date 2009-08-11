# textmate

A binary that provides package management for TextMate.

# Example

    $ textmate install javascript

    Please select a bundle from the following list:

    Github
    ------
    1. Javascript

    Macromates
    ----------
    2. JavaScript
    3. JavaScript Flash
    4. JavaScript JSDoc
    5. JavaScript MooTools
    6. JavaScript Objective-J
    7. JavaScript Prototype & Script_aculo_us
    8. JavaScript YUI
    9. JavaScript jQuery

    Which bundle would you like to install? 1

    Please select a repository from the following list:

    1. subtleGradient/javascript.tmbundle                 watchers:16  updated:2009-04-29
    2. textmate/javascript.tmbundle                       watchers:6   updated:2009-06-09
    3. rdougan/javascript.tmbundle                        watchers:2   updated:2009-01-28
    4. cohitre/javascript-tmbundle                        watchers:1   updated:2009-01-29

    Which repository would you like to install? 1

    Javascript bundle installed

    Reloading bundles...

# Usage

`textmate [COMMAND] [*PARAMS]`

Textmate bundles are automatically reloaded after install or uninstall operations.

## List available remote bundles

`textmate search [SEARCH]`

List all of the available bundles in the remote repository, optionally filtering by `search`.

## List installed bundles

`textmate list [SEARCH]`

List all of the bundles that are installed on the local system, optionally filtering by `search`.

## Installing new bundles

`textmate install NAME [SOURCE]`

Installs a bundle from the remote repository. SOURCE filters known remote bundle locations.
For example, if you want to install the "Ruby on Rails" bundle off GitHub, you'd type the following:

`textmate install "Ruby on Rails" GitHub`

Available remote bundle locations are:
* Macromates Trunk
* Macromates Review
* GitHub

## Uninstalling bundles

`textmate uninstall NAME`

Uninstalls a bundle from the local repository.
