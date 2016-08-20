# encoding: utf-8
class AccountMailer < Devise::Mailer
  
  # => add_template_helper(ViewHelper)
  # => include ViewHelper
  # => helper ViewHelper
  # => helper :view
  
  default css: 'email', from: CONFIG[:mail_system]
  
  def subject_for(key)
    I18n.t(:"#{devise_mapping.name}_subject", :scope => [:devise, :mailer, key], :default => [:subject, key.to_s.humanize], :app_name => CONFIG[:app_name])
  end
  
end