The Hurricane Florence API
====================

* We serve JSON data here, open and fresh
* We help client applications help those affeceted by Hurricane Florence.

=======
Example Clients:

Developer Links
-----

* [CONTRIBUTORS](https://github.com/hurricane-response/florence-api/graphs/contributors)
* [LICENSE](#license)
* [CODE OF CONDUCT](CODE_OF_CONDUCT.md)


API
----

### Overall

* URI: https://hurricane-florence-api.herokuapp.com
* Namespaced and versioned: `/api/v1`

* Sample API for list of all shelters: https://hurricane-florence-api.herokuapp.com/api/v1/shelters
* Sample API for list of all shelters accepting people: https://hurricane-florence-api.herokuapp.com/api/v1/shelters?accepting=true

### Shelters Endpoint

Shape:

```
{
    "shelters": [
			{
				county: "Palm Beach County",
				shelter: "Dr. Mary Mcleod Bethune Elementary School",
				address: "1501 Avenue U, West Palm Beach, Palm Beach County, FL, United States",
				city: "West Palm Beach",
				state: "Florida",
				zip: "33404",
				pets: null,
				phone: "(561) 882-7600",
				accepting: true,
				updated_by: null,
				notes: null,
				volunteer_needs: null,
				longitude: -80.084386,
				latitude: 26.776181,
				supply_needs: null,
				source: null,
				google_place_id: "ChIJoQqfCZ3V2IgRmoonj7yL5x4",
				special_needs: false,
				needs: [ ],
				updated_at: "2017-09-09T11:44:42-05:00",
				updatedAt: "2017-09-09T11:44:42-05:00",
				last_updated: "2017-09-09T11:44:42-05:00",
				cleanPhone: "5618827600"
			},
			{
				county: "Palm Beach County",
				shelter: "Palm Beach Gardens High School",
				address: "4245 Holly Drive, Palm Beach Gardens, FL, United States",
				city: "Palm Beach Gardens",
				state: "Florida",
				zip: "33410",
				pets: null,
				phone: "(561) 694-7300",
				accepting: true,
				updated_by: null,
				notes: null,
				volunteer_needs: null,
				longitude: -80.1010343,
				latitude: 26.8250767,
				supply_needs: null,
				source: null,
				google_place_id: "ChIJTyeTJ6sq2YgRT1ojAxBcxk4",
				special_needs: false,
				needs: [ ],
				updated_at: "2017-09-09T11:44:43-05:00",
				updatedAt: "2017-09-09T11:44:43-05:00",
				last_updated: "2017-09-09T11:44:43-05:00",
				cleanPhone: "5616947300"
			},
			{
				county: "Manatee County",
				shelter: "Buffalo Creek Middle School",
				address: "7320 69th St E",
				city: "Palmetto",
				state: null,
				zip: "34221",
				pets: "Yes",
				phone: "(941) 721-2260",
				accepting: true,
				updated_by: null,
				notes: null,
				volunteer_needs: null,
				longitude: -82.4907812,
				latitude: 27.5756384,
				supply_needs: null,
				source: "http://www.mymanatee.org/home/government/departments/public-safety/emergency-management/shelter-list-table.html",
				google_place_id: "ChIJb4ViKXcjw4gRicDxsEVhf4Q",
				special_needs: false,
				needs: [ ],
				updated_at: "2017-09-09T16:24:41-05:00",
				updatedAt: "2017-09-09T16:24:41-05:00",
				last_updated: "2017-09-09T16:24:41-05:00",
				cleanPhone: "9417212260"
			}
    ],
    "meta": {
        "result_count": 3,
        "filters": {
            accepting: "true"
        }
    }
}
```

Filters:

* `county` : County Name
* `accepting` : true/false
* `shelter` : the name
* `lat` and `lon` : specify the lat / lon. We'll order by the lat/lon and return results within a 100 mile radius
* `limit`: only return n results



Sample:
`/api/v1/shelters?accepting=true&county=Alachua+County`

  * Filters by Alachua County shelters accepting people

`/api/v1/shelters?shelter=Archer`

  * Filters shelters with Archer in the name

### Needs API

Shape:

```
{
    "needs": [
        {
            "updated_by": "Taylor",
            "timestamp": "2017-08-31 12:52",
            "location_name": "BBVA Compass Stadium",
            "location_address": "2200 Texas Ave, Houston, TX 77003",
            "longitude": "-95.351565",
            "latitude": "29.752355",
            "contact_for_this_location_name": "",
            "contact_for_this_location_phone_number": "",
            "are_volunteers_needed": true,
            "tell_us_about_the_volunteer_needs": "Need volunteers to process donations, sign up through Red Cross. Friday, September 1 from 8 a.m.-8 p.m. daily. More details: https://www.houstondynamo.com/post/2017/08/30/bbva-compass-stadium-capacity-no-longer-collecting-donations-storm-relief",
            "are_supplies_needed": false,
            "tell_us_about_the_supply_needs": "No longer taking donations",
            "anything_else_you_would_like_to_tell_us": ""
        }
    ],
    "meta": {
        "result_count": 1,
        "filters": {
            "location_name": "BBVA"
        }
    }
}
```

Filters:

* `supplies_needed` : true
* `volunteers_needed` : true
* `location_name` : the name
* `lat` and `lon` : specify the lat / lon. We'll order by the lat/lon and return results within a 100 mile radius
* `limit`: only return n results

Sample:

`/api/v1/needs?location_name=Montgomery`

  * Filters by location_name

`/api/v1/needs?supplies_needed=true`

  * Who needs supplies

### Products API

Shows needs as an Amazon Product, ready for purchase.

Shape:

```
{
  "products": [
    {
      "need": "pet items",
      "asin": "B00ME73XUG",
      "amazon_title": "PET FACTORY 28750 Chicken Dog Roll, 40-Pack",
      "detail_url":
        "https://www.amazon.com/FACTORY-28750-Chicken-Roll-40-Pack/dp/B00ME73XUG?psc=1&SubscriptionId=AKIAJ5PESCDQX7KIMQ5Q&tag=oneclickrelie-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B00ME73XUG",
      "priority": false,
      "category_specific": "Rawhide",
      "category_general": "Pet Supplies",
      "price_in_cents": 2352,
      "price": "$23.52"
    }
  ],
  "meta": {
    "result_count": 247
  }
}
```

Filters:

* `need` : Name of need, eg: 'baby'
* `priority` : `true`. Note: data has to be gathered to make this true
* `limit`: only return n results
* `category`: matching either the category_specific or category_general

Sample:

`/api/v1/products?limit=2&need=baby`

  * Returns 1 result, only for needs with `baby`

### Charitable Organizations API

Shape:

```
{
  "charitable_organizations": [
    {
      "name": "Boys and Girls Country",
      "services": "Children",
      "food_bank": false,
      "donation_website": "https://www.boysandgirlscountry.org/donate",
      "phone_number": "(281)351-4976",
      "email": "info@boysandgirlscountry.org",
      "physical_address": "18806 Roberts Road",
      "city": "Hockley",
      "state": "TX",
      "zip": "77447",
      "updatedAt": "2017-09-04T00:58:58.088Z"
    }
  ],

  "meta": {
    "result_count": 1,
    "filters": {
      "city": "Hockley"
    }
  }
}
```

Filters:

* `food_bank` : true
* `name` : the name
* `services` : the services provided
* `limit`: only return n results
* `city`: the organizations in a city

Sample:

`/api/v1/charitable_organizations?services=schools`

  * Filters by services provided

`/api/v1/charitable_organizations?food_bank=true`

  * Organizations acting as food banks


Getting Started (Dev)
-------
#### Prequisites
* Ruby 2.4.1
* Rails 5.1.

#### Fork Repository and clone to local machine
##### Fork Repository
* Prequisites
  * A github account and a repository into which to fork other repositories
* Steps
  1. Navigate in a browser to https://github.com/hurricane-response/florence-api
  2. Click the Fork button in the upper right of the screenshot_create-service-account-key
  3. If prompted choose into where you want to form (e.g., if you are a member of multiple github repositories)
  4. You'll now have a forked version - your own version - of the repository.
  5. Go to "Clone or download" button on right of screen and copy that URL. It will be of the format `git clone git@github.com:<YOUR OWN GITHUB REPOSITORY>/harvey-api.git`

##### Clone Fork to local box
* In the directory on your local box in which you plan to work run: `git clone git@github.com:<YOUR OWN GITHUB REPOSITORY>/harvey-api.git`

#### Setting up your .env file

* GOOGLE_GEOCODER_API_KEY = Geocoding with Google Maps API, get
  [one](https://console.developers.google.com/flows/enableapi?apiid=geocoding_backend&keyType=SERVER_SIDE)
* AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY = Product Advertising API, see
  below

Note: this is optional; currently only needed to fetch new Amazon products from
the Amazon Product Advertising API

You'll need to set the following ENV variables in a .env file

1. Make a working copy of .env by runng this command at the terminal: `cp .env.sample .env`
2. Get Amazon AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY from Amazon's IAM. You'll need to create a PolicyName. You can name it "ProductAdvertisingAPI" with the following policy:
```
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

#### Creating a local database
* Prerequisites
  * PostgreSQL is installed and running on your local machine
* Method 1: Automatic
  * Run `rails db:setup`
* Method 2: Manual
  * Create a postgres users
    It's recommended though optional that you use a distinct user for the harvey-api database
    * Example `createuser harvey-api_development -P`
    The `-P` flag will prompt you to create a password for the new user
  * Create the database (with the owner of the database set to user just created in the last step)
    * Example `createdb -O harvey-api_development harvey-api_development`
* Run rails migrate to create schema
  * `rails db:migrate`
* Import needs and shelters data from the production API:
  * `rails api:import`
  Sample output if successful
  ```
    Starting ImportSheltersJob 2017-09-03 18:33:03 +0000
    ImportSheltersJob Complete - {285}
    Starting ImportNeedsJob 2017-09-03 18:33:05 +0000
    ImportNeedsJob Complete - {92}
  ```

#### User Administration
In `rails console` you'll want to create an admin user:

```
User.create! email: "youremail@example.com", password: "yourpassword", admin: true
```

#### Test the API itself (Run API locally)
* Example `rails server `
  Screenshot of Success:
  ![Screenshot](/public/images/readme/screenshot_rails_server_run_test.png)

#### About the data import job
* You can load Amazon Products by seeding your database: `rails db:seed` (or doing a full import `rails amazon:import`)
The `ActiveJob`s and associated Rake task `rails api:import`, which imports data for shelters and needs from the production API into the application database, is intended for use in development and test environments only.

**DO NOT RUN THIS JOB IN PRODUCTION.** Since this job pulls data from the production API, running it in production can only be counter-productive, and would likely be destructive.

Development Process
-------
#### Tests and Testing
Code should have tests, and any pull requests should be made only after you've made sure passes the test suite

#### Git and Github use
We force pull-requests from feature branches to master. Once something lands in master, it goes live instantly

##### Keeping your fork in sync
* `git remote add upstream git@github.com:sketch-city/harvey-api.git`
* `git fetch upstream`

#### Branching
Within your own forked repo create branches for each logical unit for work you do. One benefit of doing this is you'll be able to periodically sync your forked repo with upstream repo into the master branch without conflicting with work you may be doing.

#### Pull Requests
When you believe your code is ready to be merged into the upstream repository (sketch-city/harvey-api) by creating a pull request. Do this by
* In github click the "Compare & pull request" button that github will present to you once you've committed changes to local repo
* Describe what you changed and why; reference the issue(s) if any that your work addresses

##### More Information and Further Reading
* More information about keeping your fork in sync with the upstream repository may be found at https://help.github.com/articles/syncing-a-fork/
* More information about branching can be found at https://git-scm.com/book/id/v2/Git-Branching-Branches-in-a-Nutshell


Documentation Standards
-------
### Inline Comment Style
(Coming Soon)

### Markdown
Documentation such as READMEs (e.g., this document) are written in markdown per the [Github standard] (https://guides.github.com/features/mastering-markdown/)


Design Choices
-------------

* Hosted on Heroku with PostGres
* Uses ActiveJob (currently with sucker_punch)
* MiniTest with Rails system tests

Thanks To:
---------

Source Code Collaborators can be viewed: https://api.harveyneeds.org/contributors.html

But the API wouldn't mean anything without our volunteers:

* [Entire Sketch-City organization](http://sketchcity.org/)
* [Code for America](https://www.codeforamerica.org/)


Appendix
---------
### Developer Resources
* [Mastering Markdown](https://guides.github.com/features/mastering-markdown)


### Errors you may get and what they mean

* "PG::ConnectionBad"
Looks like:
```rails aborted!
PG::ConnectionBad: could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```
Postgres is not running OR there is a connection problem to the database.


# LICENSE

### Software Code

This system's software code is licensed under the GPLv3.

Full license availabe in [LICENSE](LICENSE)

### Data and Content

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This
work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
