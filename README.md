A repo of script files that make our lives easier.

setup_forge3.rb
===============

I use this with an alias:

    alias sf3='setup-forge3.sh'

Then to create a new project:

1. Create the project on Github.
2. Add yourself as a collaborator.
3. Navigate to where you want your project folder to live.
4. Ensure you are using the correct ruby -- the one you use for forge3 projects.

Then run the following (where new_project is the name of the git repo) and wait for the magics to happpen:

    $ sf3 new_project

Notes:
======
* You might need to edit the line: bundle install --path vendor --without linux to reflect your OS
* You will need to change the credentials for: bundle exec rake forge:setup_database USERNAME=root PASSWORD=root

