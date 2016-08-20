# encoding: utf-8
class SubscriptionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription_mailer.thank_you.subject
  #
  def thank_you( subscription )
    @subscription = subscription
    mail to: @subscription.user ? @subscription.user.email : @subscription.email
  end
  
end
