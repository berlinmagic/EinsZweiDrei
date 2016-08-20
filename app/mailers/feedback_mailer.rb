# encoding: utf-8
class FeedbackMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.thank_you.subject
  #
  def thank_you( feedback )
    @feedback = feedback
    @that = ["bug","feature","contact"].include?(@feedback.subject) ? @feedback.subject : "else"
    mail to: @feedback.user ? @feedback.user.email : @feedback.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.feedback_recieved.subject
  #
  def feedback_recieved( feedback )
    @feedback = feedback
    @that = ["bug","feature","contact"].include?(@feedback.subject) ? @feedback.subject : "else"
    mail to: CONFIG[:mail_support], reply_to: @feedback.user ? @feedback.user.email : @feedback.email
  end
end
