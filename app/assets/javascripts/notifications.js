function SubscribableArray() {
  return {
    _items: [],
    _callbacks: [],
    clear: function() {
      this._items = []
      this._publish()
    },
    add: function(shelter) {
      this._items.push(shelter)
      this._publish()
    },
    subscribe: function(callback) {
      this._callbacks.push(callback)
    },
    _publish: function() {
      const shelters = this._items
      this._callbacks.forEach(function(cb) {
        cb(shelters)
      })
    }
  }
}

;(function() {
  this.App || (this.App = {})

  App.updatedShelters = new SubscribableArray()
  App.updatedNeeds = new SubscribableArray()
}.call(this))
