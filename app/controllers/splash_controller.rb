class SplashController < ApplicationController
  def index
    # They might not have created a home key yet
    @page = Page.home.first_or_initialize
  end
end
