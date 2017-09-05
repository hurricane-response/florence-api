class SplashController < ApplicationController
  def index
    @page = Page.find_by key: "Home"
  end
end
