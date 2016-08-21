# encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  ## Controller-Helper (lib/helper/..)
  include LocaleHelper
  include MainHelper
  include UserHelper
  
  helper :all

  ## needed to access current_user in serializers
  # => serialization_scope :current_user
  # => serialization_scope :view_context

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :devise_mapping
  helper_method :after_devise_signup_or_login_for


  protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:signup_via, :signup_url, :signup_as])
    end

  private

    # Attempt to find the mapped route for devise based on request path
    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    ## CANCAN - for & from model
    # => def current_ability
    # =>   current_user.ability
    # => end
    
    ## CANCAN - standard
    def current_ability
      @current_ability ||= Ability.new( current_user )
    end
    rescue_from CanCan::AccessDenied do |exception|
      @exception = exception
      respond_to do |format|
        format.html { redirect_to root_url, alert: exception.message }
        format.js   { render text: "window.location = '/'; alert(#{exception.message});" }
        format.json { render text: exception.message, status: 401 }
      end
    end

    def after_devise_signup_or_login_for( resource )
      stored_location_for(resource) || app_root_path
    end
    alias_method :after_sign_in_path_for, :after_devise_signup_or_login_for
    alias_method :after_inactive_sign_up_path_for, :after_devise_signup_or_login_for
    alias_method :after_sign_up_path_for, :after_devise_signup_or_login_for

end
