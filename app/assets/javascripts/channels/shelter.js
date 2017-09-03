App.shelter = App.cable.subscriptions.create("ShelterChannel", {
  connected: function() {},
  received: function(data) {
    App.updatedShelters.add(data.shelter)
  }
})
