# The Hurricane Florence API

* We serve JSON data here, open and fresh
* We help client applications help those affected by Hurricane Florence.

## Developer Quick Links

* [CONTRIBUTORS](https://github.com/hurricane-response/florence-api/graphs/contributors)
* [GETTING STARTED](#getting-started)
* [LICENSE](#license)
* [CODE OF CONDUCT](CODE_OF_CONDUCT.md)
* [CONTRIBUTING](CONTRIBUTING.md)
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

## Thanks to

Source Code Collaborators can be viewed: https://hurricane-florence-api.herokuapp.com/contributors.html

But the API wouldn't mean anything without our volunteers:

* [Entire Sketch-City organization](http://sketchcity.org/)
* [Code for America](https://www.codeforamerica.org/)

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
