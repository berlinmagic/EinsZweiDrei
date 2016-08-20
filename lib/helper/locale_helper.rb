# encoding: utf-8
module LocaleHelper
  module InstanceMethods
    
    
    private
    
    def get_user_language
      @current_locale ||= savely_get_user_language
    end
    
    def savely_get_user_language
      if CONFIG[:app_ready_for_translation]
        @accept_locale ||= get_accepted_locale
        I18n.locale = acceptable_locale?(@accept_locale) ? @accept_locale.to_sym : I18n.default_locale
      else
        I18n.locale = I18n.default_locale
      end
      I18n.locale
    end
    
    def get_accepted_locale
      if params[:locale] && !params[:locale].blank?
        params[:locale]
      elsif session[:user_locale] && !session[:user_locale].blank?
        session[:user_locale]
      elsif request.env["HTTP_ACCEPT_LANGUAGE"] && !request.env["HTTP_ACCEPT_LANGUAGE"].blank?
        if acceptable_locale?( request.env["HTTP_ACCEPT_LANGUAGE"].to_sym )
          request.env["HTTP_ACCEPT_LANGUAGE"]
        elsif acceptable_locale?( request.env["HTTP_ACCEPT_LANGUAGE"].split("-")[0].to_sym )
          request.env["HTTP_ACCEPT_LANGUAGE"].split("-")[0]
        else
          I18n.default_locale
        end
      else
        I18n.default_locale
      end
    end
    
    def acceptable_locale?( locale )
      # I18n.available_locales.include?( locale )
      # CONFIG[:app_locales].include?(locale)
      # => if Rails.env.production?
      # =>   CONFIG[:app_locales].include?(locale)
      # => else
      # =>   CONFIG[:dev_locales].include?(locale)
      # => end
      system_locales.include?( locale.to_s )
    end
    
    def get_system_locales
      if Rails.env.production?
        MagicLocales::Locale.where(locale_state: "live")
      else
        MagicLocales::Locale.where(locale_state: ["active","live"])
      end
    end
    
    def system_locales
      get_system_locales.map(&:iso_code)
    end
    
    
  end

  def self.included(receiver)
    #receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
    
    receiver.send :helper_method, :get_user_language, :system_locales, :get_system_locales, :savely_get_user_language
    
  end
  
end