# encoding: utf-8
class FeedbacksController < ApplicationController

  def create
    @feedback = Feedback.new( feedback_params )
    @feedback.user = current_user if current_user
    if @feedback.save
      redirect_to root_path, notice: "Feedback sended."
    else
      redirect_to root_path, alert: @feedback.errors.full_messages.join(" ... ")
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit( :subject, :content, :user_id, :name, :email, :current_controller, :current_action, :current_params )
    end

    def one_name
      I18n.t("activerecord.attributes.feed_back.one")
    end

end
