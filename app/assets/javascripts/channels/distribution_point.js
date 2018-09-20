App.distribution_point = App.cable.subscriptions.create("DistributionPointChannel", {
  connected: function() {},
  received: function(data) {
    App.updatedDistributionPoints.add(data.distribution_point)
  }
})
