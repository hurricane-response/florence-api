class PagesController < ApplicationController

  def index
    if(user_signed_in? && current_user.admin?)
      @pages = Page.all
    else
      redirect_to root_path
    end
  end

  def edit
    if(user_signed_in? && current_user.admin?)
      @page = Page.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if(user_signed_in? && current_user.admin?)
      @page = Page.find(params[:id])
      if @page.update(page_params)
        redirect_to root_path, notice: 'Page was successfully updated.'
      end
    else
      redirect_to root_path
    end
  end

  private

  def page_params
    params.require(:page).permit(:key, :content)
  end

end
