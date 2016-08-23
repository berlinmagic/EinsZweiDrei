# encoding: utf-8
class Backend::SettingsController < Backend::BaseController
  
  before_action :fetch_resource, only: [ :update, :destroy ]
  
  def index
   @setting = current_user.setting || ::Setting.new( )
   render :form
  end
  

  def create
    @setting = ::Setting.new( resource_params.merge( user: current_user) )
    if @setting.save
      
      redirect_to resource_domain, notice: I18n.t("messages.create_success", model: one_name)
    else
      redirect_to resource_domain, alert: I18n.t("messages.create_error", model: one_name)
    end
  end
  
  def update
    if @setting.update( resource_params )
      redirect_to resource_domain, notice: I18n.t("messages.update_success", model: one_name)
    else
      redirect_to resource_domain, alert: I18n.t("messages.update_error", model: one_name)
    end
  end
  
  def defaults
    @setting = current_user.setting || ::Setting.new( )
    @setting.update( blink_time: 10.0, stop_time: 3.0, interval_time: 150, speed_step: 20, step_time: 1000, step_type: "none", blink_type: "highlight" )
    redirect_to resource_domain, notice: "Einstellungen wurden auf Standard zurück gestzt."
  end
  
  
private
  
    def fetch_resource
      @setting = current_user.setting
    end
    
    def resource_params
      params.require( :setting ).permit( :blink_time, :stop_time, :interval_time, :speed_step, :step_time, :step_type, :blink_type )
    end
    
    def resource_domain
      app_settings_path
    end
    
    def one_name
      I18n.t("activerecord.attributes.setting.one")
    end
  
  
end
