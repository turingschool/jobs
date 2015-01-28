class ApplicationsController < ApplicationController
  before_filter :require_login, except: [:new]
  skip_before_filter :verify_authenticity_token

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

    save_or_render_new_for_bookmarklet
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

    if params[:status]
      @app.update_attributes(status: params[:status])
    else
      @app.update_attributes(application_params)
    end
    save_or_render_new
  end

  def save_or_render_new
    if @app.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def save_or_render_new_for_bookmarklet
    if @app.save
      redirect_to session[:return_to]
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

  def application_params
    params.require(:application).permit(:company,
                                        :location,
                                        :url,
                                        :applied_on,
                                        :status)
  end
end
