class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to root_path, notice: 'Page was successfully updated.'
    end
  end

  private

  def page_params
    params.require(:page).permit(:key, :content)
  end

end
