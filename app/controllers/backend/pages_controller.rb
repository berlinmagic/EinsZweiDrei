# encoding: utf-8
class Backend::PagesController < Backend::BaseController
  
  def dashboard
    @questions = current_user.questions
  end
  
  def calendar
    
  end
  
  def change_actor
    current_user.set_actor( params[:actor_id] )
    # redirect_to :back
    if current_user.current_company_id
      redirect_to dashboard_app_company_path( current_user.current_company )
    else
      redirect_to dashboard_app_user_path( current_user )
    end
  end
  
end
