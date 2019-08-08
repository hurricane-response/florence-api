# The Hurricane API Contributing

## Getting Started

### Prequisites

* A Github Account

Docker can be used to get up and running quickly, or a local environment can be setup with these tools:

* Ruby 2.6.0
* Rails 5.2
* PostgreSQL 9.6+
* Redis 4+

### Fork Repository

  1. Navigate in a browser to [https://github.com/hurricane-response/florence-api](https://github.com/hurricane-response/florence-api)
  2. Click the Fork button in the upper right of the repository frame
  3. If prompted choose into where you want to fork (e.g., if you are a member of multiple github repositories)
  4. You'll now have a forked version - your own version - of the repository

#### Clone Fork to local box

1. Go to the green "Clone or download" button on right of screen of the repository frame and copy that URL. It will be of the format `https://github.com/<YOUR OWN GITHUB REPOSITORY>/florence-api.git` (this URL will be different if you are using SSH)
2. In the directory on your local box in which you plan to work: `git clone https://github.com/<YOUR OWN GITHUB REPOSITORY>/florence-api.git`
3. Press `enter` and watch git fetch the repository for you into a sub-directory named `florence-api`

### Option 1: Setting up local environment via Docker

1. Follow the instructions that can be found within the Docker site starting [here](https://www.docker.com/get-started).
2. Once you have Docker installed and running execute the following command to build and deploy your containers locally by executing the following command from the project root directory: `RAILS_ENV=development docker-compose up --build`
3. Edit your files, work on data, develop a feature; do whatever you intend to do, at this point.  When you are finished, commit, push to github, and create a pull request if you intend to share the results of your effort with the rest of the community.
4. When you are done development work, don't forget to bring everything down gracefully by executing the following command from the project root directory:
`docker-compose down`

### Option 2: Manually setting up local environment

#### Prerequisites

- Postgres (9.6 or higher): https://wiki.postgresql.org/wiki/Detailed_installation_guides
- Ruby (using rbenv or rvm install version 2.6.0): https://www.ruby-lang.org/en/documentation/installation/
- Rails: https://guides.rubyonrails.org/getting_started.html
- Redis:
  - Linux: https://redis.io/topics/quickstart
  - Windows: https://redislabs.com/ebook/appendix-a/a-3-installing-on-windows/a-3-2-installing-redis-on-window/
  - Mac: Using homebrew:
```
  brew update
  brew install redis

  # If you want it to autorun for you at startup:
  brew services start redis

  # if you want to run it only when working:
  redis-server /usr/local/etc/redis.conf

  # test if redis is running, the following command should
  # return 'PONG':
  redis-cli ping
```

#### Database Setup Method 1: Automatic

Run `rails db:setup`

#### Database Setup Method 2: Manual

##### First Time Setup
If you are setting up your database for the first time:

* Create a postgres users
  It's recommended though optional that you use a distinct user for the harvey-api database
  * Example `createuser harvey-api_development -P`
  The `-P` flag will prompt you to create a password for the new user
* Create the database (with the owner of the database set to user just created in the last step)
  * Example `createdb -O harvey-api_development harvey-api_development`
* Run rails structure load to create the schema: `rails db:structure:load`, otherwise you can migrate to get any new updates: `rails db:migrate`

#### Importing data

##### Shelters and Needs from Production API

**DO NOT RUN THIS JOB IN PRODUCTION.** Since this job pulls data from the production API, running it in production can only be counter-productive, and would likely be destructive. The `ActiveJob`s and associated Rake task `rails api:import`, which imports data for shelters and needs from the production API into the application database, is intended for use in development and test environments only.

Import needs and shelters data from the production API: `rails api:import`

Sample output if successful

```{text}
Starting ImportSheltersJob 2017-09-03 18:33:03 +0000
ImportSheltersJob Complete - {285}
Starting ImportNeedsJob 2017-09-03 18:33:05 +0000
ImportNeedsJob Complete - {92}
```

##### Third Party Imports

There are other imports that can be run to pull data from NSS, or other source on a per-event basis.  Speak with a collaborator to find out more.

### Configuration

##### Setting up your .env file

You'll need to create a `.env` file with some ENV variables that support features in the app.

To start, make a working copy of the sample `.env` file in this repo by running this command at the terminal: `cp .env.sample .env`.

##### Google Maps API Geocoding support

To support Geocoding with Google Maps API, [get an API key](https://console.developers.google.com/flows/enableapi?apiid=geocoding_backend&keyType=SERVER_SIDE) and add it to your `.env` file with the name `GOOGLE_GEOCODER_API_KEY`:

```{env}
GOOGLE_GEOCODER_API_KEY=<your key here>
```

### User Administration

In `rails console` you'll want to create an admin user:

```{ruby}
User.create! email: "youremail@example.com", password: "yourpassword", admin: true
```

### Test the API itself (Run API locally)

Run the api with: `rails server`

Screenshot of Success:
![Screenshot](/public/images/readme/screenshot_rails_server_run_test.png)

### Development Process

#### Tests and Testing

Code should have tests, and any pull requests should be made only after you've made sure passes the test suite.

### git Repository Etiquette

#### Keeping your fork in sync

* `git remote add upstream git@github.com:hurricane-response/florence-api.git`
* `git pull upstream` and merge conflicts, if any.

#### Branching

Within your own forked repo create branches for each logical unit of work you do. One benefit of doing this is you'll be able to periodically sync your forked repo with upstream repo into the master branch without conflicting with work you may be doing.

Make sure to push your work to your fork on github frequently to save yourself if something happens to your local system.

When you find your branch diverges from master, please feel free to make liberal use of `git rebase master` on your working branch.

#### Pull Requests

When you believe your code is ready to be merged into the upstream repository (hurricane-response/florence-api) by creating a pull request. Do this by:

* In Github, click the "Compare & pull request" button that Github will present to you once you've committed changes to local repo
* Describe what you changed and why, as well as how to go about testing in the app; reference the issue(s) if any that your work addresses
* Indicate if there are potentially destructive changes in the pull request (removal of existing features, database migrations, major refactoring, etc.)

##### More Information and Further Reading

* More information about keeping your fork in sync with the upstream repository may be found at [Synching a Fork](https://help.github.com/articles/syncing-a-fork/)
* More information about branching can be found at [Git Branching in a Nutshell](https://git-scm.com/book/id/v2/Git-Branching-Branches-in-a-Nutshell)

### Source Code Style

Run `rubocop` on your changes before committing.  Take the results of this with a grain of salt, but please try to manage any style violations.

For references on common styles (that this repository deviates from somewhat), please review the style guides in the Appendix below.

Note: Keep in mind not all of the styles provided by rubocop are observed here.  One reason is rails generators do not produce code that complies with rubocop defaults.  You'll notice significant cop alterations in `.rubocop.yml`.  We will eventually get to the point where we have less alterations in the rubocop config and runs without errors, at which point we will add rubocop to our CI/CD pipeline.

### Design Choices

* Hosted on Heroku with Postgres and Redis
* Uses ActiveJob (currently with sucker_punch)
* MiniTest with Rails system tests

## Appendix

### Developer Resources

* [Mastering Markdown](https://guides.github.com/features/mastering-markdown)
* [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)
* [Rails Style Guide](https://github.com/rubocop-hq/rails-style-guide)

### Errors you may get and what they mean

**`PG::ConnectionBad`**

Looks like:

```{text}
rails aborted!
PG::ConnectionBad: could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```

This means Postgres is not running OR there is a connection problem to the database.
