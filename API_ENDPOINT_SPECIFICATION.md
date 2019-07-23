# The Hurricane API Endpoint Specification

### Routing

* Root URL: `https://api.hurricane-response.org`
* Namespaced and versioned: `/api/v1`

### Common Filtering

Filters can be applied with URL Parameters. Available filter options are provided per endpoint.


### Shelters Endpoint

`https://api.hurricane-response.org/api/v1/shelters`

#### Filter Options

* `accepting` : "yes", "no", "unknown"
* `special_needs` : boolean
* `county` : the county
* `name` : the shelter name
* `lat` and `lon` : specify the lat / lon. We'll order by the lat/lon and return results within a 100 mile radius
* `limit`: only return n results

* Sample API for list of all shelters accepting people: `https://api.hurricane-response.org/api/v1/shelters?accepting=yes`

#### Sample JSON array

```
{
  "shelters": [
    {
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
      "source": "FEMA GeoServer",
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
    },
    ...
  ],
  "meta": {
    "result_count": 154,
    "filters": {
      "accepting": "yes"
    }
  }
}
```

### Distribution Points API

`https://api.hurricane-response.org/api/v1/distribution_points`

#### Filter Options

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

#### Sample JSON array

```
{
  "distribution_points": [
    {
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
    }
  ],
  "meta": {
    "result_count": 1,
    "filters": {
      "active": "true"
    }
  }
}
```

### Needs API
`depricated`

### Products API
`depricated`

### Charitable Organizations API
`depricated`
