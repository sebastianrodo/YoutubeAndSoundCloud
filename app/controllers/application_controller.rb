require 'action_controller'

class ApplicationController < ActionController::Base
  before_action :start_api
end
