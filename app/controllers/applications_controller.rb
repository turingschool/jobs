class ApplicationsController < ApplicationController
  before_filter :require_login, except: [:new]

  def new
    set_session_url
    @app = Application.new(url: url)
    set_return_path
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
      redirect_to session[:return_to]
    else
      render :new
    end
    clear_session_url
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

  def submission_confirmation

  end

  private

  def set_return_path
    if from_bookmarklet_and_logged_in?
      session[:return_to] = application_submission_confirmation_path
    elsif from_bookmarklet?
      session[:return_to] = new_application_path(bookmarklet: true)
    else
      session[:return_to] = dashboard_path
    end
  end

  def from_bookmarklet_and_logged_in?
    params[:bookmarklet] && current_user
  end

  def from_bookmarklet?
    params[:bookmarklet]
  end

  def clear_session_url
    session[:url] = ""
  end

  def set_session_url
    session[:url] = params[:url] if params[:url]
  end

  def url
    params[:url] || session[:url]
  end
end
