function simpleMap(options) {
  var selector = options.selector
  var name = options.name || "Location"
  var lat = options.lat
  var lng = options.lng

  var element = document.querySelector(selector)
  if (!!element) {
    var map = new google.maps.Map(element, {
      zoom: 12,
      center: { lat: lat, lng: lng }
    })

    var marker = new google.maps.Marker({
      position: { lat: lat, lng: lng },
      map: map,
      title: name
    })
  }
}
