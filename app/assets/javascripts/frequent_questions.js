$(document).ready(function(){
	// Se cargan las preguntas de los taxistas
	getFrecuentQuestions(0);
	// Se cargan las preguntas de los usuarios
	getFrecuentQuestions(1);
})

/**
 * Ajax encargado de obtener las preguntas según el tipo
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[boolean]} type [Recibe un dato sea (0) -> para preguntas de taxistas ó (1) -> para las preguntas de los ususarios]
 * @return {[type]}      [description]
 */
	function getFrecuentQuestions(type){
		$.ajax({
		    // la URL para la petición
		    url : '/api/v1/questions?tipo=' + type,
		    // la información a enviar
		    // (también es posible utilizar una cadena de datos)
		     data : {  },
		    // especifica si será una petición POST o GET
		    type : 'GET',
		    // el tipo de información que se espera de respuesta   		// The content type used when sending data to the server. Default is: "application/x-www-form-urlencoded"
		    // código a ejecutar si la petición es satisfactoria;
		    // la respuesta es pasada como argumento a la función
		    success : function(obj) {
		    	//var questions = '[{"id":3,"pregunta":"¿How are you?","respuesta":"Very well","tipo":"usuarios","created_at":"2017-12-01T17:34:51.980Z","updated_at":"2017-12-01T17:34:51.980Z"}, {"id":3,"pregunta":"¿Cómo estás?","respuesta":"Hola todo bien","tipo":"usuarios","created_at":"2017-12-01T17:34:51.980Z","updated_at":"2017-12-01T17:34:51.980Z"}]';
		    	//var obj = JSON.parse(respuesta);
		    	console.log(obj);
		    	if (type) {
		    		loadFrecuentQuestions(obj, 'usuarios');
		    	}
		    	else{
		    		loadFrecuentQuestions(obj, 'taxistas');
		    	}
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
 * Carga todas las preguntas y respuestas dentro de un elemento determinado
 * @author Nikollai Hernandez G <nikollaihernandez@gmail.com>
 * @param  {[json]} questions   [Recibe un objeto de tipo json que será quien contenga la lista de preguntas frecuentes]
 * @param  {[string]} element   [Recibe como cadena el identificador del elemento en el cual se desean cargar las preguntas]
 * @return {[type]}           [description]
 */
	function loadFrecuentQuestions(questions, element){
		if (questions.length > 0) {
			var DOM_fq = '';
			for (var i = 0; i < questions.length; i++) {
				// En caso de que sea la primera pregunta que se está pintando se agrega la clase (in) para que se vea activa
				var collapse = '';
				if (i == 0) {
					collapse = 'in';
				}

				//Recorre cada una de las preguntas agregandola a una variable de tipo string que luego será pintada en el elemento que se desee
				DOM_fq += '<div class="panel panel-default">' +
				            '<div class="panel-heading">' +
				              '<h4 class="panel-title">' +
				                '<a data-toggle="collapse" data-parent="#'+element+'" href="#'+element+''+i+'">' +
				                questions[i]['pregunta'] + '</a>' +
				              '</h4>' +
				            '</div>' +
				            '<div id="'+element+''+i+'" class="panel-collapse collapse '+ collapse +'">' +
				              '<div class="panel-body">'+ questions[i]['respuesta'] +'</div>' +
				            '</div>' +
				          '</div>';
			}

			// Se carga la variable con la informacion del DOM para las preguntas
			$('#' + element).html(DOM_fq);
		}
	}
