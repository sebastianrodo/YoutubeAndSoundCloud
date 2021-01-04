require_relative '.././services/youtube_Service'

class VideosController < ApplicationController
  def index
    @start_api = YoutubeService.new
    super
  end
end
