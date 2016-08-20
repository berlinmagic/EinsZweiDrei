# encoding: utf-8
class Backend::UsersController < Backend::BaseController
  
  before_action :fetch_user, only: [ :dashboard, :edit_step, :update, :destroy, :delete_image ]
  
  FORM_STEPS = ["profile", "image", "verifications"]
  ACCOUNT_STEPS = ["password", "cancel"]
  
  def dashboard
  end
  
  def edit_step
    @step = params[:step]
    render "backend/users/forms/#{@step}"
  end
  
  
  # def update
  #   @user = current_user
  #   if @user.update( user_params )
  #     redirect_to edit_app_user_path(current_user), notice: "Profil wurde aktualisiert."
  #   else
  #     redirect_to edit_app_user_path(current_user), alert: "Profil konnte nicht aktualisiert werden."
  #   end
  # end
  
  def update
    if @user.update( user_params )
      if params[:form_step]
        path = edit_step_app_user_path(@user,params[:form_step])
      else
        path = edit_step_app_user_path(@user, "profile")
      end
      respond_to do |format|
        format.html { redirect_to path, notice: I18n.t("messages.update_success", model: one_name) }
        format.js   { render text: "window.location = '#{ path }';" }
      end
    else
      redirect_to path, alert: I18n.t("messages.update_error", model: one_name)
    end
  end
  
  def delete_image
    @user.remove_image = true
    @user.save
    redirect_to :back, notice: "Deleted Image!"
  end
  
  private
  
    def fetch_user
      @user = current_user
    end
  
    # Never trust parameters from the scary internet!
    def user_params
      params.require(:user).permit( 
                                        :first_name, :last_name, :gender, :phone, :image, :birthday
                                        # , :address_attributes => MagicAddresses::Address::PARAMS 
                                   )
    end
    
    def one_name
      I18n.t("activerecord.attributes.user.one")
    end
  
end
