//Variables globales
var packages;

$( document ).ready(function() {
    getPackages();
});

/**
 * [getPackages description]
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @return {[type]} [description]
 */
function getPackages(){
	$.ajax({
      // la URL para la petición 
      url : '/packages',
      // la información a enviar
      // (también es posible utilizar una cadena de datos)
      data : {  },
      // especifica si será una petición POST o GET
      type : 'GET',
      // el tipo de información que se espera de respuesta      // The content type used when sending data to the server. Default is: "application/x-www-form-urlencoded"
      // código a ejecutar si la petición es satisfactoria;
      // la respuesta es pasada como argumento a la función
      success : function(obj) {
        setPackages(obj);
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
 * [setPackages description]
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[type]} p [description]
 */
function setPackages(p){
	var packagesDom = '';
	if (p.length > 0) {
		var x = 0;
		for (var i = 0; i < p.length; i++) {
			var paq = p[i];
			if (x %4 == 0 || x == 0) {
				if (x == 0) {
					packagesDom += '<div class="item active">';
				}
				else{
					packagesDom += '<div class="item">';
				}
			}

			packagesDom += '<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">'+
				                '<div class="content-price">'+
				                  '<h2 class="price-name">'+paq['nombre']+'</h2>'+
				                  '<div class="content-bottom-price">'+
				                    '<div class="item-bottom-price">'+
				                      '<p>Cantidad Carreras</p>'+
				                      '<h2 class="value-price">'+parseInt(paq['cantidad_de_carreras'])+'</h2>'+
				                    '</div>'+
				                    '<div class="item-bottom-price">'+
				                      '<p>Valor</p>'+
				                      '<h2 class="value-price">$'+numberFormat(parseInt(paq['valor_de_paquete']))+' COP</h2>'+
				                    '</div>'+
				                    '<div class="item-bottom-price">'+
				                      '<p>Utilidad '+numberFormat(paq['valor_de_paquete'] * (paq['utilidad_taxista'] / 100))+' COP</p>'+
				                      '<h2 class="value-price">'+parseInt(paq['utilidad_taxista'])+'%</h2>'+
				                    '</div>'+
				                    '<div class="item-bottom-price">'+
				                      '<p>Valor a pagar</p>'+
				                      '<h2 class="value-price pay-total">$'+numberFormat(parseInt(paq['valor_de_paquete'] - (paq['valor_de_paquete'] * (paq['utilidad_taxista'] / 100))))+' COP</h2>'+
				                    '</div>'+
				                  '</div>'+
				                '</div>'+ 
				            '</div>';
			x++;

			if (x %4 == 0 || x == p.length) {
				packagesDom += '</div>';
			}
		}
	}

	$('#theCarousel .carousel-inner').html(packagesDom);
}

/**
 * [numberFormat description]
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[type]} number        [description]
 * @param  {Number} decimals      [description]
 * @param  {String} dec_point     [description]
 * @param  {String} thousands_sep [description]
 * @return {[type]}               [description]
 */
function numberFormat(number, decimals = 0, dec_point = '.', thousands_sep = '.') {
    // Strip all characters but numerical ones.
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec) {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;
        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}