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

  def edit
    @app = Application.find(params[:id])
  end

  def update
    @app = Application.find(params[:id])

    @app.company    = params[:application][:company]
    @app.location   = params[:application][:location]
    @app.url        = params[:application][:url]
    @app.applied_on = params[:application][:applied_on]
    @app.status     = params[:application][:status]

    if @app.save
      redirect_to application_path(@app)
    else
      render :new
    end
  end
end
