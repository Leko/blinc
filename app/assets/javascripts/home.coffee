# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init = ->
  mapOptions =
    center:
      lat: 35.2640093
      lng: 139.1526721
    zoom: 12
  map = new google.maps.Map(document.getElementById('maps'), mapOptions)
  drawSegments(map, gon.storyline)

drawSegments = (map, segments) ->
  paths = []
  for segment in segments
    continue if segment.type != 'place'
    place = segment.place
    latlng = new google.maps.LatLng(place.location.lat, place.location.lon)
    paths.push(latlng)
    console.log 'append', place.name || 'Unknown', place
    marker = new google.maps.Marker
      position: latlng
      map: map
      title: place.name || 'Unknown'
  polyline = new google.maps.Polyline
    path: paths
    geodesic: true
    strokeColor: '#FF0000'
    strokeOpacity: 1.0
    strokeWeight: 2
  polyline.setMap(map)

console.log(gon.storyline)
init()
