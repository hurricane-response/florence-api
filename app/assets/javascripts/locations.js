var placeSearch, autocomplete

// Invoked by google maps script tag callback
function initAutocomplete() {
  if (document.querySelector("#autocomplete")) {
    // Create the autocomplete object, restricting the search to geographical
    // location types.
    autocomplete = new google.maps.places.Autocomplete(
      document.getElementById("autocomplete")
    )
    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
    autocomplete.addListener("place_changed", fillInAddress)
  }
}

function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace()

  var lat = place.geometry.location.lat()
  var lon = place.geometry.location.lng()
  var address = place.formatted_address
  var googlePlaceId = place.place_id
  var city = ""
  var cityComponent = place.address_components.find(
    c => c.types.indexOf("locality") >= 0
  )
  if (cityComponent) {
    city = cityComponent.long_name
  }
  setInputIfExists("input.address", address)
  setInputIfExists("input.location_address", address)
  setInputIfExists("input.city", city)
  setInputIfExists("input.lat", lat)
  setInputIfExists("input.lon", lon)
}

function setInputIfExists(selector, value) {
  var input = document.querySelector(selector)
  if (input) {
    input.value = value
  } else {
    console.log(`[geocoding] Input with ${selector} not found.`)
  }
}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      }
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      })
      autocomplete.setBounds(circle.getBounds())
    })
  }
}
