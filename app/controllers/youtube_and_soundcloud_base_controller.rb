require 'will_paginate/array'
require 'action_controller'
require 'pry'

class YoutubeAndSoundcloudBaseController < ApplicationController
  def index
    @results = @start_api.init_search(params[:q]).paginate(page: params[:page])
  end
end
