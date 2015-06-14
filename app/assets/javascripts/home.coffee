# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

paths = []
requests = []
completed = 0
bounds = new google.maps.LatLngBounds()

openInfo = (marker, place, latlng) ->
  geocoder = new google.maps.Geocoder()
  service  = new google.maps.places.PlacesService(map)
  loading  = $('<div></div>').append(
    $('<h2></h2>').text(place.name || 'Unknown'),
    $('<p></p>').html('Loading...'))

  infoWindow = new google.maps.InfoWindow
    content: loading.get(0).outerHTML
    maxWidth: 300
  infoWindow.open(map, marker)
  geocoder.geocode {location: latlng}, (results) ->
    request = {placeId: results[0].place_id}
    service.getDetails request, (info, status) ->
      if status == google.maps.places.PlacesServiceStatus.OK
        [address, photos] = [info.formatted_address, info.photos]
      else
        [address, photos] = ['Fetch detail failed...', []]
      loading.find('p').html(address)
      if photos
        loading.prepend $('<img>').attr('src', photos[0].getUrl({maxWidth: 300}))
      infoWindow.setContent loading.get(0).outerHTML

# グローバルを書き換えるので複雑になりそう。
drawSegments = (idx) ->
  paths[idx] = []
  (segments) ->
    segments.forEach (segment) ->
      place = segment.place
      latlng = new google.maps.LatLng(place.location.lat, place.location.lon)
      paths[idx].push latlng
      return unless segment.type
      bounds.extend(latlng)
      map.fitBounds(bounds)
      marker = new google.maps.Marker
        position: latlng
        title: place.name || 'Unknown'
        animation: google.maps.Animation.DROP
        map: map
      google.maps.event.addListener marker, 'click', ->
        openInfo(marker, place, latlng)

drawPolylines = (paths) ->
  flat_paths = []
  flat_paths = flat_paths.concat(path) for path in paths

  polyline = new google.maps.Polyline
    path: flat_paths
    geodesic: true
    strokeColor: '#FF0000'
    strokeOpacity: 1.0
    strokeWeight: 2
  polyline.setMap(map)

progress = ->
  $('#progress').css('width', (completed++ / requests.length) * 100 + '%')
  return (requests.length - completed) == 0

finished = ->
  $('#progress').removeAttr('style').addClass('progress-done')
  drawPolylines(paths)

fetchSegments = (profile) ->
  SPAN = 1000 * 60 * 60 * 24 * 7
  date = profile.firstDate
  since = new Date(+date.substr(0, 4), +date.substr(4, 2) - 1, +date.substr(6, 2))
  now = new Date()

  paths = []
  requests = []
  i = 0

  while since.getTime() < now.getTime()
    dfd = $.getJSON('/moves/storylines', {
      from: since
      to: since + SPAN
    })
    draw = drawSegments(i++)
    dfd.always (segments) ->
      done = progress()
      finished() if done
      draw(segments) if Array.isArray(segments)

    requests.push dfd
    since.setTime Math.min(since.getTime() + SPAN, now.getTime())

maps = document.getElementById('maps')
if maps
  mapOptions =
    center:
      lat: 35.2640093
      lng: 139.1526721
    zoom: 12
    panControl: false
    rotateControl: false
    zoomControlOptions:
      position: google.maps.ControlPosition.RIGHT_BOTTOM
      style: google.maps.ZoomControlStyle.LARGE
    mapTypeControlOptions:
      position: google.maps.ControlPosition.BOTTOM_RIGHT
      style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
  map = new google.maps.Map(maps, mapOptions)

  $.getJSON('/moves/profiles')
    .done fetchSegments
