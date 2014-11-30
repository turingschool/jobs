class ApplicationsController < ApplicationController
  def new
    @app = Application.new(:status => Application.statuses.first)
  end

  def create
    @app = Application.new(
      :company    => params[:application][:company],
      :location   => params[:application][:location],
      :url        => params[:application][:url],
      :applied_on => params[:application][:applied_on],
      :status     => params[:application][:status]
    )

    if @app.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    @application = Application.find(params[:id])
  end
end
