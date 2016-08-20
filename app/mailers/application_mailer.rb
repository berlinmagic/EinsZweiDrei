class ApplicationMailer < ActionMailer::Base
  
  default css: 'email', from: CONFIG[:mail_system]
  
  layout 'mailer'
  
  helper :application
  
end
