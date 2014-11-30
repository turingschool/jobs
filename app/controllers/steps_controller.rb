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
      redirect_to @application
    else
      render :new
    end
  end

  def edit
    @application = Application.find(params[:application_id])
    @step = @application.steps.find(params[:id])
  end

  def update
    @application = Application.find(params[:application_id])
    @step = @application.steps.find(params[:id])
    @step.kind = params[:step][:kind]
    @step.note = params[:step][:note]

    if @step.save
      redirect_to @application
    else
      render :edit
    end
  end
end
