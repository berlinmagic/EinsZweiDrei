# encoding: binary
class EmailValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    unless value =~ MailReg::EmailAddress
      record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.messages.email_error_message')) 
    end
  end
  
end
