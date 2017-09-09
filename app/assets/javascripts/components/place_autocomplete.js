(function() {
  function PlaceAutocomplete(el, opts) {
    var _this = this;

    this.el = el;
    this.opts = opts;

    this.autocomplete = new google.maps.places.Autocomplete(el, {
      componentRestrictions: { country: 'us' }
    });

    this.autocomplete.addListener('place_changed', function() {
      var place = _this.autocomplete.getPlace();

      if (!!place.name) {
        $(_this.opts.fillName).val(place.name);
      } else {
        $(_this.opts.fillName).val('');
      }

      if (!!place.formatted_address) {
        $(_this.opts.fillAddress).val(place.formatted_address);
      } else {
        $(_this.opts.fillAddress).val('');
      }

      if (!!place.formatted_phone_number) {
        $(_this.opts.fillPhone).val(place.formatted_phone_number);
      } else {
        $(_this.opts.fillPhone).val('');
      }

      if (!!place.geometry && !!place.geometry.location) {
        $(_this.opts.fillLat).val(place.geometry.location.lat());
        $(_this.opts.fillLng).val(place.geometry.location.lng());
      } else {
        $(_this.opts.fillLat).val('');
        $(_this.opts.fillLng).val('');
      }

      if (!!place.place_id) {
        $(_this.opts.fillPlaceId).val(place.place_id);
      } else {
        $(_this.opts.fillPlaceId).val('');
      }
    });
  }

  $(function () {
    $('input.place-autocomplete').each(function() {
      var $el = $(this);

      new PlaceAutocomplete(this, {
        fillName: $el.data('name'),
        fillAddress: $el.data('address'),
        fillPhone: $el.data('phone'),
        fillLat: $el.data('lat'),
        fillLng: $el.data('lng'),
        fillPlaceId: $el.data('placeid')
      });
    });
  });
})();

