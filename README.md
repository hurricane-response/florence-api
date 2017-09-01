The Harvey Needs API
====================

* Imports data from a public google data spreadsheet
* Each import does a full import of the needs and shelter sheets
* We serve JSON data here, open and fresh
* viasocket notifies our api when changes have been made to the source data in Google sheets. The api then does a full refresh of the data from the Google sheet.will post to us when an update is posted to the google spreadsheet
* An ad-hoc import can be triggered with `rails google:import`

API
----

### Overall

* URI: https://api.harveyneeds.org
* Namespaced and versioned: `/api/v1`

* Sample API for list of all shelters: https://api.harveyneeds.org/api/v1/shelters
* Sample API for list of all shelters accepting people: https://api.harveyneeds.org/api/v1/shelters?accepting=true

### Shelters Endpoint

Shape:

```
{
    "shelters": [
        {
            "county": "Fort Bend",
            "shelter": "Gallery Furniture Grand Parkway",
            "address": "7227 W. Grand Parkway South",
            "city": "Richmond",
            "pets": "Yes, crated and kept by owner's side",
            "phone": "(281) 407-7161",
            "accepting": true,
            "last_updated": "2017-08-30 12:50 PM",
            "updated_by": "bon",
            "notes": "No answer (info here by Jane at 8/29/2017 21:17:00)",
            "volunteer_needs": "Open up for volunteers in the morning, 8/30th",
            "longitude": "-95.7505562",
            "latitude": "29.673294",
            "supply_needs": "toiletries, water, juice, gatorade",
            "source": ""
        },
        {
            "county": "Harris",
            "shelter": "Gallery Furniture",
            "address": "6006 N. Freeway",
            "city": "Houston",
            "pets": "Yes",
            "phone": "(713) 694-5570",
            "accepting": false,
            "last_updated": "2017-08-30 12:57 PM",
            "updated_by": "bon",
            "notes": "No answer (info here by Claudia at 8/29 10:48am; At max capacity.)",
            "volunteer_needs": "",
            "longitude": "-95.396748",
            "latitude": "29.854114",
            "supply_needs": "trucks to move people to GRB or other shelters. ",
            "source": ""
        }
    ],
    "meta": {
        "result_count": 5,
        "filters": {
            "shelter": "Gallery"
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
`/api/v1/shelters?county=fort bend&accepting=true`

  * Filters by fort bend shelters accepting people

`/api/v1/shelters?shelter=Gallery`

  * Filters shelters with Gallery in the name

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
