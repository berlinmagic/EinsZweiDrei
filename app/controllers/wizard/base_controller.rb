# encoding: utf-8
class Wizard::BaseController < ApplicationController
  
  layout proc { |controller| controller.request.xhr? ? false : "admin" }
  
  before_action :authenticate_admin!
  
  
  private
  
    def authenticate_admin!
      unless current_user && current_user.is_wizard?
        # redirect_to root_path, alert: "Only for admins, dude!"
        session["user_return_to"] = request.fullpath
        redirect_to new_user_session_path, alert: "Only for admins, dude!"
      end
    end
  
end
