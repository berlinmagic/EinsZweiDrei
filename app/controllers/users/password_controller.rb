# encoding: utf-8
class Users::PasswordController < ApplicationController
  
  def pick
    @user = User.find( params[:id] )
    if @user.tmp_password
      render "devise/passwords/pick"
    else
      redirect_to root_path, alert: I18n.t("devise.passwords.pick.allready_set_message")
    end
  end
  
  def update
    @user = User.find( params[:id] )
    if @user.tmp_password
      @user.reset_password!( password_params[:new_password], password_params[:new_password_confirmation] )
    end
    sign_in( @user )
    redirect_to root_path, notice: I18n.t("devise.passwords.pick.success_message")
  end
  
  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def password_params
      params.require(:user).permit( :new_password, :new_password_confirmation )
    end
  
end