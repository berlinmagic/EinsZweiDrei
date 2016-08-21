# encoding: utf-8
class FrontendController < ApplicationController

  ## front-pages except start:
  PAGEZ = %w(privacy imprint)

  before_action :authenticate_user!,  only: []
  before_action :authenticate_admin!, only: []

  def start
    render "frontend/start" #, layout: "blank"
  end

  def show
    if params[:page] && PAGEZ.include?( params[:page] )
      @title = I18n.t("titles.#{params[:page]}")
      render "frontend/#{ params[:page] }" #, layout: "blank"
      
    else
      redirect_to root_path, alert: "Page not found!"
    end
  end
  
  def game
    render "frontend/game", layout: "game"
  end

  private

    def authenticate_admin!
      unless current_user && current_user.is_wizard?
        redirect_to root_path, alert: "Only for admins, dude!"
      end
    end

end
