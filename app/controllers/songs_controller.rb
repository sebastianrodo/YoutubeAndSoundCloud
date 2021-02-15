require 'will_paginate/array'

class SongsController < YoutubeAndSoundcloudBaseController
  def start_api
    @start_api = SoundcloudService.new
  end
end
