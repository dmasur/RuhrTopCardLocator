window.geolocation =
{
  getLocation: function() {
    return {
      then: function(callback) {
        callback({ coords: { latitude: "51.4317", longitude: "7" } });
      }
    }
  }
}