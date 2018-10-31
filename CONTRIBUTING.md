# The Hurricane Florence API

* We serve JSON data here, open and fresh
* We help client applications help those affected by Hurricane Florence.

## Contributing

### Getting Started

#### Prequisites

* Ruby 2.4.1
* Rails 5.1
* Docker (Optional)

##### Fork Repository

* Prequisites
  * A github account and a repository into which to fork other repositories
* Steps
  1. Navigate in a browser to https://github.com/hurricane-response/florence-api
  2. Click the Fork button in the upper right of the screenshot_create-service-account-key
  3. If prompted choose into where you want to form (e.g., if you are a member of multiple github repositories)
  4. You'll now have a forked version - your own version - of the repository.
  5. Go to "Clone or download" button on right of screen and copy that URL. It will be of the format `git clone git@github.com:<YOUR OWN GITHUB REPOSITORY>/florence-api.git`

#### Clone Fork to local box

* In the directory on your local box in which you plan to work run: `git clone git@github.com:<YOUR OWN GITHUB REPOSITORY>/florence-api.git`

#### Configuration

##### Setting up your .env file

You'll need to create a `.env` file with some ENV variables that support features in the app.

To start, make a working copy of the sample `.env` file in this repo by running this command at the terminal: `cp .env.sample .env`.

##### Google Maps API Geocoding support

To support Geocoding with Google Maps API, [get an API key](https://console.developers.google.com/flows/enableapi?apiid=geocoding_backend&keyType=SERVER_SIDE) and add it to your `.env` file with the name `GOOGLE_GEOCODER_API_KEY`:

```{env}
GOOGLE_GEOCODER_API_KEY=<your key here>
```

##### Amazon Products support

**Note:** this is optional; currently only needed to fetch new Amazon products from the Amazon Product Advertising API.

Ensure you have an Amazon AWS account. Once you do, login and go to the IAM (Identity & Access Management) service. There, you'll do the following things:

1. If you prefer, create a user for this service.
2. With the user you want to use for this purpose, get an Access Key and Secret Key from IAM. Make sure to record these in a convenient place (a password keeper, for example), as the Secret Key cannot be retrieved once initially provided.
3. Create an IAM Policy named `Product Advertising API` as follows:
  ```{json}
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ProductAdvertisingAPI:*",
            "Resource": "*"
        }
    ]
}
```
4. Attach the IAM Policy you created to the user you created for whom you the keys.

Once these steps are complete, add the keys to your `.env` file as follows:

```{env}
AWS_ACCESS_KEY_ID=<Access Key here>
AWS_SECRET_ACCESS_KEY=<Secret Key here>
```

#### Setting up local environment via Docker

##### Docker

1. Follow the instructions that can be found within the Docker site starting [here](https://www.docker.com/get-started).
2. Once you have Docker installed and running execute the following command to build and deploy your containers locally by executing the following command from the project root directory:
```sh
RAILS_ENV=development docker-compose up --build
```
3. When you are done development work, don't forget to bring everything down gracefully by executing the following command from the project root directory:
```sh
docker-compose down
```

#### Setting up local environment manually

##### Prerequisites

* PostgreSQL (9.2+) is installed and running on your local machine

##### Method 1: Automatic

Run `rails db:setup`

##### Method 2: Manual

* Create a postgres users
  It's recommended though optional that you use a distinct user for the harvey-api database
  * Example `createuser harvey-api_development -P`
  The `-P` flag will prompt you to create a password for the new user
* Create the database (with the owner of the database set to user just created in the last step)
  * Example `createdb -O harvey-api_development harvey-api_development`

##### Ensuring you have the latest schema

Run rails migrate to create/update schema: `rails db:migrate`

##### Importing data

###### Shelters and Needs from Production API

Import needs and shelters data from the production API: `rails api:import`

Sample output if successful

```{text}
Starting ImportSheltersJob 2017-09-03 18:33:03 +0000
ImportSheltersJob Complete - {285}
Starting ImportNeedsJob 2017-09-03 18:33:05 +0000
ImportNeedsJob Complete - {92}
```

**DO NOT RUN THIS JOB IN PRODUCTION.** Since this job pulls data from the production API, running it in production can only be counter-productive, and would likely be destructive. The `ActiveJob`s and associated Rake task `rails api:import`, which imports data for shelters and needs from the production API into the application database, is intended for use in development and test environments only.

###### Amazon Products Data (optional)

You can load Amazon Products by seeding your database: `rails db:seed`, or doing a full import `rails amazon:import`

#### User Administration

In `rails console` you'll want to create an admin user:

```{ruby}
User.create! email: "youremail@example.com", password: "yourpassword", admin: true
```

#### Test the API itself (Run API locally)

Run the api with: `rails server`

Screenshot of Success:
![Screenshot](/public/images/readme/screenshot_rails_server_run_test.png)

### Development Process

#### Tests and Testing

Code should have tests, and any pull requests should be made only after you've made sure passes the test suite

#### Git and Github use

We force pull-requests from feature branches to master. Once something lands in master, it goes live instantly

##### Keeping your fork in sync

* `git remote add upstream git@github.com:hurricane-response/florence-api.git`
* `git fetch upstream`

#### Branching

Within your own forked repo create branches for each logical unit for work you do. One benefit of doing this is you'll be able to periodically sync your forked repo with upstream repo into the master branch without conflicting with work you may be doing.

#### Pull Requests

When you believe your code is ready to be merged into the upstream repository (hurricane-response/florence-api) by creating a pull request. Do this by:

* In Github, click the "Compare & pull request" button that Github will present to you once you've committed changes to local repo
* Describe what you changed and why, as well as how to go about testing in the app; reference the issue(s) if any that your work addresses
* Indicate if there are potentially destructive changes in the pull request (removal of existing features, database migrations, major refactoring, etc.)

##### More Information and Further Reading

* More information about keeping your fork in sync with the upstream repository may be found at https://help.github.com/articles/syncing-a-fork/
* More information about branching can be found at https://git-scm.com/book/id/v2/Git-Branching-Branches-in-a-Nutshell

### Documentation Standards

#### Inline Comment Style

(Coming Soon)

#### Markdown

Documentation such as READMEs (e.g., this document) are written in markdown per the [Github standard] (https://guides.github.com/features/mastering-markdown/)

### Design Choices

* Hosted on Heroku with PostGres
* Uses ActiveJob (currently with sucker_punch)
* MiniTest with Rails system tests

## Appendix

### Developer Resources

* [Mastering Markdown](https://guides.github.com/features/mastering-markdown)

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
