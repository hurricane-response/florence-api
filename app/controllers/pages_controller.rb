class PagesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_page, only: %i[edit update destroy]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to pages_path, notice: "`#{@page.key}` page was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to pages_path, notice: 'Page was successfully updated.'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: 'Page was successfully destroyed.'
  end

private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:key, :content)
  end

end
