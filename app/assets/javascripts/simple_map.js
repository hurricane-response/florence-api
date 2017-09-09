function simpleMap({ selector, name = "Location", lat, lng }) {
  var element = document.querySelector(selector)
  if (!!element) {
    var map = new google.maps.Map(element, {
      zoom: 12,
      center: { lat, lng }
    })

    var marker = new google.maps.Marker({
      position: { lat, lng },
      map: map,
      title: name
    })
  }
}
