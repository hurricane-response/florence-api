App.need = App.cable.subscriptions.create("NeedChannel", {
  connected: function() {},
  received: function(data) {
    App.updatedNeeds.add(data.need)
  }
})
