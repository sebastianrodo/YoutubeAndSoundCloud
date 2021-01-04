require 'will_paginate/array'
require_relative '.././services/soundcloud_service'

class SongsController < ApplicationController
  def index
    @start_api = SoundcloudService.new
    super
  end
end
