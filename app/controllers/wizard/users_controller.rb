# encoding: utf-8
class Wizard::UsersController < Wizard::BaseController
  
  def index
    @users = User.order(created_at: :desc).includes(:authentications)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy unless @user.is_wizard || @user.is_master_wizard
    redirect_to :back, notice: "User was deleted!"
  end
  
  
  def make_admin
    @user = User.find(params[:id])
    authorize! :manage, @user
    @user.is_wizard = true
    if @user.save
      redirect_to :back, notice: "#{@user.name || @user.email} is now an Admin!"
    else
      redirect_to :back, alert: "Couldn't make '#{@user.name || @user.email} an Admin! "
    end
  end
  
  def remove_admin
    @user = User.find(params[:id])
    authorize! :manage, @user
    @user.is_wizard = false
    if @user.save
      redirect_to :back, notice: "#{@user.name || @user.email} no Admin anymore!"
    else
      redirect_to :back, alert: "Couldn't remove Admin-state from '#{@user.name || @user.email}!"
    end
  end
  
  def act_as
    return unless current_user.is_wizard?
    @user = User.find(params[:uid])
    authorize! :act_as, @user
    sign_in(:user, @user)
    redirect_to root_url # or user_root_url
  end
  
  
end
