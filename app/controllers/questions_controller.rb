class QuestionsController < LockController
  	before_action :questions, only: [:index]
    before_action :set_question, only: [:edit, :update, :destroy]
  
    breadcrumb 'Preguntas frecuentes', :questions_path
    breadcrumb 'Crear', :new_question_path, only: [:new]

	def index
      
    end

    def new
	    @question = Question.new
	end

	def edit
	end

	def create
	    @question = Question.new(question_params)
	    if @question.save
	      	flash[:success] = 'La pregunta fue registrada correctamente!'
	      	redirect_to edit_question_path(@question)
	    else
	      	flash[:error] = 'Error al registrar la pregunta!'
	      	render :new
	    end
	end


	def update
	    if @question.update_attributes(question_params)
	      	flash[:success] = 'La pregunta fue modificada correctamente!'
	      	redirect_to edit_question_path(@question)
	    else
	      	flash[:error] = 'Error al modificar la pregunta!'
	      	render :new
	    end
	end

	def destroy
		if @question.destroy
			flash[:success] = 'La pregunta fue eliminada correctamente!'
		else
			flash[:error] = 'Error al eliminar la pregunta'
		end
		redirect_to questions_path
	end

    private 
    	def question_params
	      	params.require(:question).permit(
	        	:pregunta, 
        		:respuesta, 
        		:tipo
	      	)
	    end
    	def set_question
		   @question = Question.find(params[:id])
		end

		def questions
			@q = Question.ransack(params[:q])
	    	@questions = @q.result(distinct: true)
		end
end
