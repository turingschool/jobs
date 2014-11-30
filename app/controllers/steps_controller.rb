class StepsController < ApplicationController
  before_action :load_application

  def load_application
    @application = Application.find(params[:application_id])
  end

  def new
    @step = @application.steps.new
  end

  def create
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
    @step = @application.steps.find(params[:id])
  end

  def update
    @step = @application.steps.find(params[:id])
    @step.kind = params[:step][:kind]
    @step.note = params[:step][:note]

    if @step.save
      redirect_to @application
    else
      render :edit
    end
  end

  def destroy
    @step = @application.steps.find(params[:id])
    @step.destroy
    redirect_to @application
  end
end
