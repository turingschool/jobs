class HomeController < ApplicationController
  def index
    render layout: "home_page_layout"
  end
end
