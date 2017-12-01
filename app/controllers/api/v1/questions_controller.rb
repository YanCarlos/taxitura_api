module Api::V1
  class QuestionsController < ApplicationController
    before_action :set_question, only:[:update, :show, :destroy]

    include Concerns::Response
    include Concerns::ExceptionHandler

    def index
      unless filter_questions
       @questions = Question.all
       json_response(@questions, @questions.count)
      end
    end

    def show
      json_response(@question)
    end

    def create
      @question = Question.create!(question_params)
      json_response(@question, :created)
    end

    def update
      @question.update(question_params)
      json_response(@question, :updated)
    end

    def destroy
      @question.destroy
      json_response(@question, :deleted)
    end


    private
    def question_params
      params.permit(
        :pregunta, 
        :respuesta, 
        :tipo
      )
    end

    def set_question
      @question = Question.find(params[:id])
    end

    def filter_questions
      return false unless params[:tipo]
      @questions = Question.where(:tipo => params[:tipo])
      questions_count = 0
      if @questions
        questions_count = @questions.count
      end
      json_response(@questions, questions_count)
    end


  end
end
