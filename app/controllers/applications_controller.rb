class ApplicationsController < ApplicationController
  before_filter :require_login
  skip_before_filter  :verify_authenticity_token

  def new
    @app = Application.new(url: params[:uri])
  end

  def create
    @app = current_user.applications.new(
      company:      params[:application][:company],
      location:     params[:application][:location],
      url:          params[:application][:url],
      applied_on:   params[:application][:applied_on],
      status:       params[:application][:status],
      contact_info: params[:application][:contact_info],
      tier:         params[:application][:tier],
      priority:     params[:application][:priority]
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
    @app = current_person.applications.find(params[:id])
  end

  def update
    @app = current_person.applications.find(params[:id])

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

  def destroy
    @app = current_person.applications.find(params[:id])
    @app.destroy
    redirect_to dashboard_path
  end
end
