class MapPage

  constructor: ->
    @myLatLang = new google.maps.LatLng(40.716026,-73.9502848)
    @initMap()
    setTimeout =>
      @addMarker()
    , 2000

  initMap: =>
    mapOptions =
      # How zoomed in you want the map to start at (always required)
      zoom: 14

      disableDefaultUI: true

      scrollwheel: false

      # The latitude and longitude to center the map (always required)
      center: new google.maps.LatLng(40.716026,-73.9502848)

      # How you would like to style the map.
      # This is where you would paste any style found on Snazzy Maps.
      styles: [
        {
          featureType: "water"
          elementType: "geometry"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 17
            }
          ]
        }
        {
          featureType: "poi.attraction"
          elementType: "geometry"
          stylers: [
            {
              color: "#b30c19"
            }
            {
              lightness: 17
            }
          ]
        }
        {
          featureType: "landscape.manmade"
          elementType: "geometry"
          stylers: [
            {
              color: "#539EC2"
            }
          ]
        }
        {
          featureType: "landscape"
          elementType: "geometry"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 20
            }
          ]
        }
        {
          featureType: "road.highway"
          elementType: "geometry.fill"
          stylers: [
            {
              color: "#3C88BB"
            }
            {
              lightness: 17
            }
          ]
        }
        {
          featureType: "road.highway"
          elementType: "geometry.stroke"
          stylers: [
            {
              color: "#3C88BB"
            }
            {
              lightness: 29
            }
            {
              weight: 0.2
            }
          ]
        }
        {
          featureType: "road.arterial"
          elementType: "geometry"
          stylers: [
            {
              color: "#3C88BB"
            }
            {
              lightness: 18
            }
          ]
        }
        {
          featureType: "road.local"
          elementType: "geometry"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 16
            }
          ]
        }
        {
          featureType: "poi"
          elementType: "geometry"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 21
            }
          ]
        }
        {
          elementType: "labels.text.stroke"
          stylers: [
            {
              visibility: "on"
            }
            {
              color: "#5B9DC3"
            }
            {
              lightness: 16
            }
          ]
        }
        {
          elementType: "labels.text.fill"
          stylers: [
            {
              saturation: 36
            }
            {
              color: "#B0E7FF"
            }
            {
              lightness: 40
            }
          ]
        }
        {
          elementType: "labels.icon"
          stylers: [visibility: "off"]
        }
        {
          featureType: "transit"
          elementType: "geometry"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 19
            }
          ]
        }
        {
          featureType: "administrative"
          elementType: "geometry.fill"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 20
            }
          ]
        }
        {
          featureType: "administrative"
          elementType: "geometry.stroke"
          stylers: [
            {
              color: "#5B9DC3"
            }
            {
              lightness: 17
            }
            {
              weight: 1.2
            }
          ]
        }
      ]

    mapElement = document.getElementById("map")

    # Create the Google Map using out element and options defined above
    @map = new google.maps.Map(mapElement, mapOptions)


  addMarker: =>
    @marker = new google.maps.Marker(
      position: @myLatLang
      map: @map
      # icon: "/images/homepage/vestorly-cursor.png"
      animation: google.maps.Animation.DROP
    )

$ ->
  $(window).load ->
    if google? && google.maps? && google.maps.Map?
      new MapPage

