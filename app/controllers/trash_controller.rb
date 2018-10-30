class TrashController < ApplicationController
  before_action :authenticate_admin!, only: [:destroy]
  before_action :set_trash, only: [:show, :destroy]

  def index
    @trash = Trash.all
  end

  def show
    @columns = @resource.class::ColumnNames
    @headers = @resource.class::HeaderNames
  end

  def destroy
    if resource = @trash.restore!
      redirect_to resource
    else
      redirect_to trash_path, notice: "Could not restore '#{@resource.name}' (#{@trash.trashable_type}/#{@trash.trashable_id})."
    end
  end

private

  def set_trash
    @trash = Trash.find(params[:id])
    @resource = @trash.resource
  end
end
