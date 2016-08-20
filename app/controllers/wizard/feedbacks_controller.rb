# encoding: utf-8
class Wizard::FeedbacksController < Wizard::BaseController
  
  def index
    @feedbacks = ::Feedback.order(created_at: :desc).all
  end
  
  def show
    @feedback = ::Feedback.find( params[:id] )
  end
  
  def destroy
    feedback = ::Feedback.find( params[:id] )
    feedback.destroy
    redirect_to admin_feedbacks_path, notice: "Feedback was successfully deleted."
  end
  
end
