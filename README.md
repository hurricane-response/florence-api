# The Hurricane Florence API

* We serve JSON data here, open and fresh
* We help client applications help those affected by Hurricane Florence.

## Developer Quick Links

* [CONTRIBUTORS](https://github.com/hurricane-response/florence-api/graphs/contributors)
* [GETTING STARTED](#getting-started)
* [LICENSE](#license)
* [CODE OF CONDUCT](CODE_OF_CONDUCT.md)
* [CHANGELOG](CHANGELOG.md)

## API Specification

### Overall

* URI: https://hurricane-florence-api.herokuapp.com
* Namespaced and versioned: `/api/v1`

* Sample API for list of all shelters: https://hurricane-florence-api.herokuapp.com/api/v1/shelters
* Sample API for list of all shelters accepting people: https://hurricane-florence-api.herokuapp.com/api/v1/shelters?accepting=true

### Shelters Endpoint

Shape (with truncated `"shelters"` array):

```{json}
{
  "shelters": [{
    "county": "Halifax County",
    "shelter": "Kirkwood Adams Community Center",
    "address": "1100 Hamilton St, Roanoke Rapids, NC 27870, USA",
    "city": "Roanoke Rapids",
    "state": null,
    "zip": "27870",
    "phone": "(252) 533-2847",
    "accepting": true,
    "updated_by": null,
    "notes": null,
    "volunteer_needs": null,
    "longitude": -77.656588,
    "latitude": 36.453215,
    "supply_needs": null,
    "source": null,
    "google_place_id": "ChIJQ4dpqM0QrokR26weAUx2W3A",
    "special_needs": false,
    "id": 20,
    "pets": "No",
    "pets_notes": null,
    "needs": [],
    "updated_at": "2018-09-12T10:57:48-05:00",
    "updatedAt": "2018-09-12T10:57:48-05:00",
    "last_updated": "2018-09-12T10:57:48-05:00",
    "cleanPhone": "2525332847"
  }, {
    "county": "Chatham County",
    "shelter": "Chatham Middle School",
    "address": "2025 S 2nd Ave Exd, Siler City, NC 27344, USA",
    "city": "Siler City",
    "state": null,
    "zip": "27344",
    "phone": "(919) 663-2414",
    "accepting": true,
    "updated_by": null,
    "notes": null,
    "volunteer_needs": null,
    "longitude": -79.4471715,
    "latitude": 35.707201,
    "supply_needs": null,
    "source": null,
    "google_place_id": "ChIJD6tN9XRMU4gRUd7DfIO6S3g",
    "special_needs": false,
    "id": 31,
    "pets": "Yes",
    "pets_notes": null,
    "needs": [],
    "updated_at": "2018-09-13T19:16:19-05:00",
    "updatedAt": "2018-09-13T19:16:19-05:00",
    "last_updated": "2018-09-13T19:16:19-05:00",
    "cleanPhone": "9196632414"
  }, {
    "county": "Johnston County",
    "shelter": "West Johnston High School",
    "address": "5935 Raleigh Rd, Benson, NC 27504, USA",
    "city": "Benson",
    "state": null,
    "zip": "27504",
    "phone": "(919) 934-7333",
    "accepting": true,
    "updated_by": null,
    "notes": null,
    "volunteer_needs": null,
    "longitude": -78.5381849,
    "latitude": 35.5237203,
    "supply_needs": null,
    "source": null,
    "google_place_id": "ChIJVWw5mj57rIkRKh8huvYkSJo",
    "special_needs": false,
    "id": 28,
    "pets": "Yes",
    "pets_notes": null,
    "needs": [],
    "updated_at": "2018-09-13T11:04:18-05:00",
    "updatedAt": "2018-09-13T11:04:18-05:00",
    "last_updated": "2018-09-13T11:04:18-05:00",
    "cleanPhone": "9199347333"
  }],
  "meta": {
    "result_count": 154,
    "filters": {
      "accepting": "true"
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

### Distribution Points API

Shape:

```
{
    "distribution_points": [{
        "active": true,
        "facility_name": "Aurora Volunteer Fire Department",
        "address": "99 NC-33, Aurora, NC 27806, USA",
        "city": "Aurora",
        "county": "Beaufort County",
        "state": "North Carolina",
        "zip": "27806",
        "created_at": "2018-09-20T01:17:51.163Z",
        "updated_at": "2018-09-19T20:17:51-05:00",
        "updated_by": null,
        "source": "CEDR",
        "notes": null,
        "longitude": -76.7805402,
        "latitude": 35.300329,
        "google_place_id": "ChIJvwUAsqBJr4kRCyHLlSGkWLo",
        "id": 1,
        "updatedAt": "2018-09-19T20:17:51-05:00",
        "last_updated": "2018-09-19T20:17:51-05:00"
    }],
    "meta": {
        "result_count": 1,
        "filters": {
            "active": "true"
        }
    }
}
```


Filters:

* `active` : true
* `county` : the county
* `name` : the facility name
* `lat` and `lon` : specify the lat / lon. We'll order by the lat/lon and return results within a 100 mile radius
* `limit`: only return n results

Sample:

`/api/v1/distribution_points?active=true`

  * Filters out non-active distribution points

`/api/v1/distribution_points?name=Aurora`

  * Filters by facility name

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


## Contributing

### Getting Started

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
  5. Go to "Clone or download" button on right of screen and copy that URL. It will be of the format `git clone git@github.com:<YOUR OWN GITHUB REPOSITORY>/florence-api.git`

##### Clone Fork to local box

* In the directory on your local box in which you plan to work run: `git clone git@github.com:<YOUR OWN GITHUB REPOSITORY>/florence-api.git`

#### Setting up your .env file

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

#### Setting up a local database

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

## Thanks to

Source Code Collaborators can be viewed: https://hurricane-florence-api.herokuapp.com/contributors.html

But the API wouldn't mean anything without our volunteers:

* [Entire Sketch-City organization](http://sketchcity.org/)
* [Code for America](https://www.codeforamerica.org/)

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

## LICENSE

### Software Code

This system's software code is licensed under the GPLv3.

Full license available in [LICENSE](LICENSE)

### Data and Content

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This
work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
