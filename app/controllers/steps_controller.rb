class StepsController < ApplicationController
  def new
    @application = Application.find(params[:application_id])
    @step = @application.steps.new
  end

  def create
    @application = Application.find(params[:application_id])
    @step = @application.steps.new(
      :kind => params[:step][:kind],
      :note => params[:step][:note]
    )

    if @step.save
      redirect_to dashboard_path
    else
      render :new
    end
  end
end
