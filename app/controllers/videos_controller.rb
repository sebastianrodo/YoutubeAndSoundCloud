class VideosController < YoutubeAndSoundcloudBaseController
  def start_api
    @start_api = YoutubeService.new
  end
end
