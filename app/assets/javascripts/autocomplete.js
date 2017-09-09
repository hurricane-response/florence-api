(function() {
  const initializeAutocomplete = function(element) {
    const autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });

    google.maps.event.addDomListener(element, 'keydown', function(e) {
      // don't submit the whole form if the user hits enter on the autocomplete
      if (e.keyCode === 13) {
        e.preventDefault();
      }
    });

    autocomplete.addListener('place_changed', function() {
      const place = autocomplete.getPlace();
      const lat = place.geometry.location.lat();
      const lng = place.geometry.location.lng();
      let city, county, state, zip;

      for (const i in place.address_components) {
        for (const j in place.address_components[i].types) {
          switch (place.address_components[i].types[j]) {
            case 'locality': // city
              city = place.address_components[i].long_name;
              break;
            case 'administrative_area_level_2': // county
              county = place.address_components[i].long_name;
              break;
            case 'administrative_area_level_1': // state
              state = place.address_components[i].long_name;
              break;
            case 'postal_code':
              zip = place.address_components[i].long_name;
              break;
          }
        }
      }

      $(element).closest('form').find('[name="shelter[city]"]').val(city);
      $(element).closest('form').find('[name="shelter[county]"]').val(county);
      $(element).closest('form').find('[name="shelter[state]"]').val(state);
      $(element).closest('form').find('[name="shelter[zip]"]').val(zip);
      $(element).closest('form').find('[name="shelter[latitude]"]').val(lat);
      $(element).closest('form').find('[name="shelter[longitude]"]').val(lng);
      $(element).closest('form').find('[name="shelter[google_place_id]"]').val(place.place_id);
    });
  };

  window.App = window.App || {};
  window.App.initializeAutocompletes = function() {
    $('.autocomplete-field').each(function() {
      initializeAutocomplete(this);
    });
  };
})();
