;(function() {
  function PlaceAutocomplete(el, opts, callback) {
    var _this = this

    this.el = el
    this.opts = opts
    this.callback = callback

    this.autocomplete = new google.maps.places.Autocomplete(el, {})

    this.autocomplete.addListener("place_changed", function() {
      var place = _this.autocomplete.getPlace()

      if (!!place.name) {
        $(_this.opts.fillName).val(place.name)
      } else {
        $(_this.opts.fillName).val("")
      }

      if (!!place.formatted_address) {
        $(_this.opts.fillAddress).val(place.formatted_address)
      } else {
        $(_this.opts.fillAddress).val("")
      }

      if (!!place.formatted_phone_number) {
        $(_this.opts.fillPhone).val(place.formatted_phone_number)
      } else {
        $(_this.opts.fillPhone).val("")
      }

      var cityComponent = place.address_components.find(function(c) {
        return c.types.indexOf("locality") >= 0
      })
      if (!!cityComponent) {
        $(_this.opts.fillCity).val(cityComponent.long_name)
      } else {
        $(_this.opts.fillCity).val("")
      }

      var countyComponent = place.address_components.find(function(c) {
        return c.types.indexOf("administrative_area_level_2") >= 0
      })
      if (!!countyComponent) {
        $(_this.opts.fillCounty).val(countyComponent.long_name)
      } else {
        $(_this.opts.fillCounty).val("")
      }

      var zipComponent = place.address_components.find(function(c) {
        return c.types.indexOf("postal_code") >= 0
      })
      if (!!zipComponent) {
        $(_this.opts.fillZip).val(zipComponent.long_name)
      } else {
        $(_this.opts.fillZip).val("")
      }

      var stateComponent = place.address_components.find(function(c) {
        return c.types.indexOf("administrative_area_level_1") >= 0
      })
      if (!!stateComponent) {
        $(_this.opts.fillState).val(stateComponent.long_name)
      } else {
        $(_this.opts.fillState).val("")
      }

      if (!!place.formatted_phone_number) {
        $(_this.opts.fillPhone).val(place.formatted_phone_number)
      } else {
        $(_this.opts.fillPhone).val("")
      }

      if (!!place.geometry && !!place.geometry.location) {
        $(_this.opts.fillLat).val(place.geometry.location.lat())
        $(_this.opts.fillLng).val(place.geometry.location.lng())
      } else {
        $(_this.opts.fillLat).val("")
        $(_this.opts.fillLng).val("")
      }

      if (!!place.place_id) {
        $(_this.opts.fillPlaceId).val(place.place_id)
      } else {
        $(_this.opts.fillPlaceId).val("")
      }

      if (!!callback) {
        callback(place)
      }
    })
  }

  $(function() {
    $("input.place-autocomplete").each(function() {
      var $el = $(this)

      new PlaceAutocomplete(
        this,
        {
          fillName: $el.data("name"),
          fillAddress: $el.data("address"),
          fillPhone: $el.data("phone"),
          fillLat: $el.data("lat"),
          fillLng: $el.data("lng"),
          fillPlaceId: $el.data("placeid"),
          fillCity: $el.data("city"),
          fillCounty: $el.data("county"),
          fillZip: $el.data("zip"),
          fillState: $el.data("state")
        },
        function(place) {
          var selector = $el.data("mapselector")
          if (!!selector) {
            simpleMap({
              selector: selector,
              name: place.name,
              lat: place.geometry.location.lat(),
              lng: place.geometry.location.lng()
            })
          }
        }
      )
    })
  })
})()
