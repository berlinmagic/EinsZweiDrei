# encoding: utf-8
class Users::ConfirmationsController < Devise::ConfirmationsController
  
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      if resource.tmp_password
        flash.now[:notice] = I18n.t("devise.passwords.pick.confirmed_pick_passord_message")
        render "devise/passwords/pick"
        # redirect_to user_pick_password_path(resource), notice: I18n.t("devise.passwords.pick.confirmed_pick_passord_message")
      else
        set_flash_message(:notice, :confirmed) if is_flashing_format?
        respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
      end
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end
  
  private
  
    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      if signed_in?(resource_name)
        signed_in_root_path(resource)
      else
        new_session_path(resource_name)
      end
    end
  
end