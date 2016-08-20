# encoding: utf-8
class Feedback < ActiveRecord::Base

  extend Enumerize

  # =====> R E W R I T E S <================================================================= #

  # =====> C O N S T A N T S <=============================================================== #

  # =====> A S S O Z I A T I O N S <========================================================= #
  belongs_to :user,  class_name: "User", foreign_key: :user_id

  # =====> A T T R I B U T E S <============================================================= #
  enumerize :subject, in: [:feature, :bug, :contact], predicates: true

  # =====> V A L I D A T I O N <============================================================= #
  validates :subject,     presence: true
  validates :content,     presence: true
  validates :name,        presence: true
  validates :email,       presence: true
  validates :email,       email: { message: I18n.t("subscriptions.messages.invalid_mail") }

  # =====> C A L L B A C K S <=============================================================== #
  before_validation   :prefill_user
  after_create        :inform_involved

  # =====> S C O P E S <===================================================================== #

  # =====> C L A S S - M E T H O D S <======================================================= #

  # =====> I N S T A N C E - M E T H O D S <================================================= #

  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
private

  def no_user_present?
    !self.user
  end
  
  def prefill_user
    if self.user
      self.name   ||= self.user.name 
      self.email  ||= self.user.email
    end
  end
  
  def inform_involved
    ## emails 
    if defined?(Sidekiq)
      ::FeedbackMailer.delay.thank_you( self )
      ::FeedbackMailer.delay.feedback_recieved( self )
    else
      ::FeedbackMailer.thank_you( self ).deliver
      ::FeedbackMailer.feedback_recieved( self ).deliver
    end
    ## slack
    # => SlackService.inform( text, type, self.name, pic )
    # => SlackWorker.perform_async( self.class.to_s, self.id )
  end


end
