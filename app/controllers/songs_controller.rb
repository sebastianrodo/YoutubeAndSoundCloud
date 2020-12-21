require 'will_paginate/array'

class SongsController < ApplicationController
  def index
    query = params[:q]
    @start_api = SoundcloudSearch.new
    @result_search = @start_api.search(query).paginate(page: params[:page], per_page: 5)
  end
end
