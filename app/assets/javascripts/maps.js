// VARIABLES GLOBALES
var map;
var markers = [];

/**
 * Inicializa un mapa en un contenedor con identificador (map)
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @return {[type]} [description]
 */
function initMap() {
    var uluru = {lat: 3.8703456, lng: -77.0037288};
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
      center: uluru,
      styles: getStyle()
    });



    // Llama la función encargada de obtener la lista de puntos de recarga
    getRechargeHomes();
}


/**
 * Funcion encargada de obtener la lista de puntos de recarga mediante una peticion ajax
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @return {[type]} [description]
 */
function getRechargeHomes(){
  $.ajax({
      // la URL para la petición
      url : '/api/v1/recharge_homes',
      // la información a enviar
      // (también es posible utilizar una cadena de datos)
      data : {  },
      // especifica si será una petición POST o GET
      type : 'GET',
      // el tipo de información que se espera de respuesta      // The content type used when sending data to the server. Default is: "application/x-www-form-urlencoded"
      // código a ejecutar si la petición es satisfactoria;
      // la respuesta es pasada como argumento a la función
      success : function(obj) {
        // var questions = '[{"id":3,"latitud":3.8793456,"longitud":-77.0257588,"nombre":"Punto # 2","created_at":"2017-12-01T17:34:51.980Z","direccion":"Calle 14 # 5-34 Esquina"}, {"id":3,"latitud":3.8703686,"longitud":-77.0047288,"nombre":"Punto # 1","created_at":"2017-12-01T17:34:51.980Z","direccion":"Carrera 12 bis # 12-45 N"}]';
        // var obj = JSON.parse(questions);
        loadMarkers(obj);
        loadMarkersList(obj);
      },
      // código a ejecutar si la petición falla;
      // son pasados como argumentos a la función
      // el objeto de la petición en crudo y código de estatus de la petición
      error : function(xhr, status,error) {
          //redireccionarAlLogin();
          console.log("Error: " + xhr.resposeText );
      },
       // código a ejecutar sin importar si la petición falló o no
      complete : function(xhr, status) {
          //console.log(xhr);
      }
  });
}

/**
 * Carga cada uno de los puntos de recargas como marcadores en el mapa
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[json]} sites [Recibe un objeto de tipo json donde vienen cada uno de los puntos de recargas]
 * @return {[type]}       [description]
 */
function loadMarkers(sites){
  var infowindow;
  var marker;
  
  if (sites.length > 0) {
    for (var i = 0; i < sites.length; i++) {
      // Se crea el marcador el el mapa con la información del punto
      var position_site = {lat: sites[i]['latitud'], lng: sites[i]['longitud']};
      marker = new google.maps.Marker({
        position: position_site,
        map: map,
        title: sites[i]['nombre'],
        icon: '/assets/marker.png'
      });

      // El marcador creado es agregado a un array de marcadores para despues ser utilizados
      markers.push(marker);

      // Add multiple markers to map
      var infoWindow = new google.maps.InfoWindow(), marker, i;

     // Agrega el infowindow al marcador correspondiente  
      google.maps.event.addListener(marker, 'click', (function(marker, i) {
          return function() {
              infoWindow.setContent('<b>'+sites[i]['nombre']+'</b><br>' + sites[i]['direccion']);
              infoWindow.open(map, marker);
          }
      })(marker, i));
    }
  }
}

/**
 * Caga una lista con la información de cada uno de los mapas obtenidos
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[json]} sites [Recibe un objeto de tipo json con la lista de marcadores que se desean crear]
 * @return {[type]}       [description]
 */
function loadMarkersList(sites){
  if (sites.length > 0) {
    var DOM_sites = '';
    for (var i = 0; i < sites.length; i++) {
      DOM_sites += '<li class="map-list">' +
                      '<article data-position="'+i+'" class="map-item">' +
                        '<i class="fa fa-map-marker"></i>' +
                        '<div class="map-list-info">' +
                          '<h3 class="map-title">'+sites[i]['nombre']+'</h3>' +
                          '<p class="map-subtitle">'+sites[i]['direccion']+'</p>' +
                        '</div>' +
                      '</article>' +
                    '</li>';
    }

    $('.content-list-map').html(DOM_sites);
  }
}

/**
 * Esta funcion recibe el identificador de un marcador y mostrara el infowindow correspondiente, posterior a esto
 * centrará el mapa en la posición del marcador
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[int]} id [Recibe el identificador del marcador que se desea ver]
 * @return {[type]}    [description]
 */
function openMarker(id){
    google.maps.event.trigger(markers[id], 'click');
    map.setCenter(markers[id]['position']);
}

/**
 * Define un estilo para el mapa según la hora del día
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @return {[json]} [Json de estilos para el mapa]
 */
function getStyle(){
  var f = new Date();

  var hora_actual = new Date(parseInt(f.getFullYear()), parseInt(f.getMonth()), parseInt(f.getDate()), parseInt(f.getHours()), parseInt(f.getMinutes()), parseInt(f.getSeconds()));
  var hora_inicio_dia = new Date(parseInt(f.getFullYear()), parseInt(f.getMonth()), parseInt(f.getDate()), 5, 0, 1);
  var hora_inicio_noche = new Date(parseInt(f.getFullYear()), parseInt(f.getMonth()), parseInt(f.getDate()), 18, 0, 0);
  
  if ((hora_actual > hora_inicio_dia) && hora_actual < hora_inicio_noche) {
    var estilo = [
                  {
                      "featureType": "all",
                      "elementType": "labels.text.fill",
                      "stylers": [
                          {
                              "color": "#7c93a3"
                          },
                          {
                              "lightness": "-10"
                          }
                      ]
                  },
                  {
                      "featureType": "administrative.country",
                      "elementType": "geometry",
                      "stylers": [
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "administrative.country",
                      "elementType": "geometry.stroke",
                      "stylers": [
                          {
                              "color": "#a0a4a5"
                          }
                      ]
                  },
                  {
                      "featureType": "administrative.province",
                      "elementType": "geometry.stroke",
                      "stylers": [
                          {
                              "color": "#62838e"
                          }
                      ]
                  },
                  {
                      "featureType": "landscape",
                      "elementType": "geometry.fill",
                      "stylers": [
                          {
                              "color": "#dde3e3"
                          }
                      ]
                  },
                  {
                      "featureType": "landscape.man_made",
                      "elementType": "geometry.stroke",
                      "stylers": [
                          {
                              "color": "#3f4a51"
                          },
                          {
                              "weight": "0.30"
                          }
                      ]
                  },
                  {
                      "featureType": "poi",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "simplified"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.attraction",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.business",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "off"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.government",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "off"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.park",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.place_of_worship",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "off"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.school",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "off"
                          }
                      ]
                  },
                  {
                      "featureType": "poi.sports_complex",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "off"
                          }
                      ]
                  },
                  {
                      "featureType": "road",
                      "elementType": "all",
                      "stylers": [
                          {
                              "saturation": "-100"
                          },
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "road",
                      "elementType": "geometry.stroke",
                      "stylers": [
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "road.highway",
                      "elementType": "geometry.fill",
                      "stylers": [
                          {
                              "color": "#bbcacf"
                          }
                      ]
                  },
                  {
                      "featureType": "road.highway",
                      "elementType": "geometry.stroke",
                      "stylers": [
                          {
                              "lightness": "0"
                          },
                          {
                              "color": "#bbcacf"
                          },
                          {
                              "weight": "0.50"
                          }
                      ]
                  },
                  {
                      "featureType": "road.highway",
                      "elementType": "labels",
                      "stylers": [
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "road.highway",
                      "elementType": "labels.text",
                      "stylers": [
                          {
                              "visibility": "on"
                          }
                      ]
                  },
                  {
                      "featureType": "road.highway.controlled_access",
                      "elementType": "geometry.fill",
                      "stylers": [
                          {
                              "color": "#ffffff"
                          }
                      ]
                  },
                  {
                      "featureType": "road.highway.controlled_access",
                      "elementType": "geometry.stroke",
                      "stylers": [
                          {
                              "color": "#a9b4b8"
                          }
                      ]
                  },
                  {
                      "featureType": "road.arterial",
                      "elementType": "labels.icon",
                      "stylers": [
                          {
                              "invert_lightness": true
                          },
                          {
                              "saturation": "-7"
                          },
                          {
                              "lightness": "3"
                          },
                          {
                              "gamma": "1.80"
                          },
                          {
                              "weight": "0.01"
                          }
                      ]
                  },
                  {
                      "featureType": "transit",
                      "elementType": "all",
                      "stylers": [
                          {
                              "visibility": "off"
                          }
                      ]
                  },
                  {
                      "featureType": "water",
                      "elementType": "geometry.fill",
                      "stylers": [
                          {
                              "color": "#a3c7df"
                          }
                      ]
                  }
              ];
  }
  else{
    var estilo = [
                    {
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#242f3e"
                        }
                      ]
                    },
                    {
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#746855"
                        }
                      ]
                    },
                    {
                      "elementType": "labels.text.stroke",
                      "stylers": [
                        {
                          "color": "#242f3e"
                        }
                      ]
                    },
                    {
                      "featureType": "administrative.locality",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#d59563"
                        }
                      ]
                    },
                    {
                      "featureType": "poi",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#d59563"
                        }
                      ]
                    },
                    {
                      "featureType": "poi.park",
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#263c3f"
                        }
                      ]
                    },
                    {
                      "featureType": "poi.park",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#6b9a76"
                        }
                      ]
                    },
                    {
                      "featureType": "road",
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#38414e"
                        }
                      ]
                    },
                    {
                      "featureType": "road",
                      "elementType": "geometry.stroke",
                      "stylers": [
                        {
                          "color": "#212a37"
                        }
                      ]
                    },
                    {
                      "featureType": "road",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#9ca5b3"
                        }
                      ]
                    },
                    {
                      "featureType": "road.highway",
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#746855"
                        }
                      ]
                    },
                    {
                      "featureType": "road.highway",
                      "elementType": "geometry.stroke",
                      "stylers": [
                        {
                          "color": "#1f2835"
                        }
                      ]
                    },
                    {
                      "featureType": "road.highway",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#f3d19c"
                        }
                      ]
                    },
                    {
                      "featureType": "transit",
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#2f3948"
                        }
                      ]
                    },
                    {
                      "featureType": "transit.station",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#d59563"
                        }
                      ]
                    },
                    {
                      "featureType": "water",
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#17263c"
                        }
                      ]
                    },
                    {
                      "featureType": "water",
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#515c6d"
                        }
                      ]
                    },
                    {
                      "featureType": "water",
                      "elementType": "labels.text.stroke",
                      "stylers": [
                        {
                          "color": "#17263c"
                        }
                      ]
                    }
                  ];
  }

  return estilo;
}

// Evento click para los items de la lista
$(document).on('click', '.map-item', function (e) {
    openMarker($(this).attr('data-position'));
});
