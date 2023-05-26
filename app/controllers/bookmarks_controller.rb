class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = Bookmark.find(params[:id])
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(params_bookmark)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def delete
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to list_path(@list), status: :see_other
  end

  private

  def params_bookmark
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
