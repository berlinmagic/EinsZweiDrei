MagicLocales::BaseController.class_eval do 
  
  layout proc { |controller| controller.request.xhr? ? 'xhr' : "admin" }
  
  private
    # overwrite authentication method
    def authenticate_visitor
      unless current_user && current_user.is_wizard?
        session["user_return_to"] = request.fullpath
        redirect_to new_user_session_path, alert: "Only for admins, dude!"
      end
    end
end