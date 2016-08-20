# encoding: utf-8
class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.where( email: subscription_params[:email].strip.downcase ).first_or_create
    @subscription.newsletter = true
    @subscription.user = current_user if current_user
    @subscription.user_ip = request.remote_ip
    if @subscription.save
      redirect_to contact_path, notice: "Newsletter subscribed."
    else
      redirect_to contact_path, alert: @subscription.errors.full_messages.join(" ... ")
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit( :email, :newsletter, :dev_news )
    end

    def one_name
      I18n.t("activerecord.attributes.subscription.one")
    end

end
