require 'will_paginate/array'

class ApplicationController < ActionController::Base
  def index
    @results = @start_api.init_search(params[:q]).paginate(page: params[:page], per_page: 3)
  end
end
