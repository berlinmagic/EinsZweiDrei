# encoding: utf-8
class Backend::BaseController < ApplicationController
  
  layout proc { |controller| controller.request.xhr? ? false : "backend" }
  
  before_action :authenticate_user!
  
end
