class VideosController < ApplicationController
  def index
    query = params[:q]
    @yt_search = YoutubeSearch.new
    @results = @yt_search.search(query).paginate(page: params[:page], per_page: 3)
  end
end
