# encoding: utf-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def provider
    @auth = auth_params
    log_provider_request
    if current_user
      do_connect()
    else
      if auth_params[:params] && auth_params[:params][:what] && auth_params[:params][:what] == "sign_up"
        do_sign_up()
      else
        do_sign_in()
      end
    end
  end
  alias_method :facebook, :provider
  alias_method :google_oauth2, :provider


private
    
    def do_connect
      log_lines( 3 ) ; log "sign_in" ; log_lines( 3 )
      @authentication = Authentication.where( @auth.slice("provider", "uid", "email") ).first_or_create!( link: @auth["link"] )
      current_user.authentications << @authentication unless current_user.authentications.include?(@authentication)
      redirect_to edit_step_app_user_path(current_user,"verifications"), notice: "Connected with #{@auth["provider"].to_s.gsub(/_oauth2$/, "").titleize}."
    end
    
    def do_sign_in
      log_lines( 3 ) ; log "sign_in" ; log_lines( 3 )
      if Authentication.where( @auth.slice("provider", "uid", "email") ).any?
        @authentication = Authentication.where( @auth.slice("provider", "uid", "email") ).first
        @user = @authentication.user
        sign_in( :user, @user )
        redirect_to after_devise_signup_or_login_for( @user )
      elsif User.where( @auth.slice("email") ).any?
        @user = User.where( @auth.slice("email") ).first
        @authentication = Authentication.where( @auth.slice("provider", "uid", "email") ).first_or_create!( link: @auth["link"] )
        @user.authentications << @authentication unless @user.authentications.include?(@authentication)
        sign_in( :user, @user )
        redirect_to after_devise_signup_or_login_for( @user )
      else
        redirect_to new_user_session_path, alert: "There is no account for: #{ @auth["email"] }!"
      end
    end
    
    def do_sign_up
      log_lines( 3 ) ; log "sign_up" ; log_lines( 3 )
      if Authentication.where( @auth.slice("provider", "uid", "email") ).any?
        redirect_to page_path("join_us"), alert: "You allready have an account!"
      else
        if User.where(email: @auth["email"]).any?
          redirect_to page_path("join_us"), alert: "There is allready an account, with the email: #{ @auth["email"] }!"
        else
          @authentication = Authentication.where( @auth.slice("provider", "email") ).first_or_create
          @authentication.assign_attributes(link: @auth["link"], uid: @auth["uid"])
          @password = Devise.friendly_token.first(10) # maybe send via mail?
          @user = User.new(
            email: @auth["email"],
            gender: @auth["gender"],
            first_name: @auth["first_name"],
            last_name: @auth["last_name"],
            password: @password,
            signup_via: @auth["provider"].to_s.gsub(/_oauth2$/, ""),
            # signup_url: @auth["orignin_url"].to_s,
            signup_url: @auth["params"] && @auth["params"]["where"].present? ? @auth["params"]["where"] : nil
            # => language: I18n.available_locales.include?( @auth["locale"].to_s.split("_")[0] ) ? @auth["locale"].to_s.split("_")[0] : nil
          )
          # confirm user if confirmed at social network
          if (@auth["verified"] && (@auth["verified"] == true || @auth["verified"] == "true")) || (@auth["verified_email"] && (@auth["verified_email"] == true || @auth["verified_email"] == "true"))
            @user.confirm!
          end
          if @user.save
            @authentication.save
            @user.authentications << @authentication
            sign_in( :user, @user )
            redirect_to after_devise_signup_or_login_for( @user ), notice: "Successfully signed up with #{ @auth["provider"].to_s.humanize }"
          else
            redirect_to page_path("join_us"), alert: "Couldn't Sing up!<br/>#{@user.errors.full_messages.join(" ... ")}"
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auth_params
      auth = request.env["omniauth.auth"]
      hash = request.env["omniauth.auth"]
      authparams =  { params: request.env["omniauth.params"], orignin_url: request.env['omniauth.origin'].to_s }
      hash.merge! authparams
      hash.merge! auth["extra"]["raw_info"] if auth && auth["extra"] && auth["extra"]["raw_info"]
      hash.merge! auth["info"] if auth && auth["info"]
      parameters = ActionController::Parameters.new(hash)
      parameters.permit(        :uid, :provider, :username, :id,
                                :email,   :gender, 
                                :first_name, :last_name, :name,
                                :birthday, :image, 
                                :verified, :verified_email, 
                                :link, :locale, :timezone, :orignin_url,
                                :params => [:what, :where, :as]
                        )
    end
    
    
    def log_provider_request
      if Rails.env.development?
        # log_lines
        # log request.env["omniauth.auth"].to_yaml
        log_lines
        log request.env["omniauth.params"].to_yaml
        log_lines
        log request.env['omniauth.origin']
        log_lines
        log @auth.to_yaml
      end
      log_lines
      log I18n.l Time.zone.now
      log "Provider:: #{@auth[:provider]}"
      log @auth[:name]   if @auth && @auth[:name]
      log @auth[:email]  if @auth && @auth[:email]
      log " ... "
    end
    
    def log( stuff = "# # # # # # # #" )
      Rails.logger.info stuff
    end
    
    def log_lines( cnt = 2 )
      cnt.times do
        log
      end
    end
  
end