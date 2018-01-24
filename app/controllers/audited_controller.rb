class AuditedController < ApplicationController
  before_action :set_model, only: [:index]

  def index
    @models = @model.audits
  end

  private
  def set_model
    @model = params[:model].classify.constantize.find(params[:id])
  end


end
