
function setLocationOnMap(latitude,longitude) {
    if(!latitude || !longitude)
      return false;
    var mapOptions = {
        zoom: 14,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        disableDefaultUI: true,
        mapTypeControl: false,
        minZoom: 3,
        maxZoom: 15,
        scrollwheel: true,
        zoomControlOptions: {
            'position' : google.maps.ControlPosition.RIGHT_BOTTOM,
             'style' : google.maps.ZoomControlStyle.SMALL
        },
        mapTypeControl: false
    };

    var map = new google.maps.Map(document.getElementById("gmap"), mapOptions);

    var mapLocation = new google.maps.LatLng(latitude,longitude);

    map.setCenter(mapLocation);

    marker = new google.maps.Marker({
        map: map,
        draggable: false,
        position: mapLocation
    });

}