The Harvey Needs API
====================

* Imports data from a public google data spreadsheet
* Each import does a full import of the needs and shelter sheets
* We serve JSON data here, open and fresh
* viasocket will post to us when an update is posted to the google spreadsheet
* We can also trigger an import with `rails google:import`

Getting Started (Dev)
-------

You'll need to set the following ENV variables in a .env file

1. `cp .env.sample .env`
2. `atom .env` to edit the VARS
3. Get a server credential from google for
   https://console.developers.google.com/apis/api/drive.googleapis.com/overview
4. Get the private key and email from the json file google gets you
5. Those are the ENV to use

Design Choices
-------------

* one benefit of building our own api is so that we can get rid of using
  google-sheets eventually. 
* Hosted on Heroku and Amazon RDS

Thanks To:
---------

* Entire Sketch-City organization
* Coding for America
* More More More names here


