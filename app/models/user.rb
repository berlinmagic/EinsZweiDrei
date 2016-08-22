# encoding: utf-8
class User < ActiveRecord::Base
  
  extend Enumerize
  include InitialsGenerator
  
  # =====> R E W R I T E S <================================================================= #
  def to_param
    "#{self.id}#{'-' + self.name.parameterize if self.name.present? }"
  end
  
  # =====> C O N S T A N T S <=============================================================== #
  GENDERS = %w(male female)
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  devise  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, 
          :validatable, :confirmable, :lockable, :timeoutable, :omniauthable,
          :omniauth_providers => CONFIG[:devise_provider]
  
  has_many  :authentications, class_name: "Authentication", foreign_key: :user_id, dependent: :destroy
  has_many  :feedbacks,       class_name: "Feedback",       foreign_key: :user_id
  has_one   :subscription,    class_name: "Subscription",   foreign_key: :user_id
  
  has_many  :questions,       class_name: "Question",       foreign_key: :user_id
  
  has_one   :setting,         class_name: "Setting",        foreign_key: :user_id
  
  
  # has_one_address
  
  
  # =====> A T T R I B U T E S <============================================================= #
  # => dragonfly is included via InitialsGenerator
  has_user_image
  
  enumerize :gender, in: [:male, :female], predicates: true
  
  
  # =====> V A L I D A T I O N <============================================================= #
  
  # =====> C A L L B A C K S <=============================================================== #
  before_save       :ensure_authentication_token
  before_validation :check_for_changes
  before_create     :build_user_settings
  
  # =====> S C O P E S <===================================================================== #
  
  # =====> C L A S S - M E T H O D S <======================================================= #
  def self.find_by_authentication_token( token )
    find_by( api_auth_token: token )
  end
  
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  def is_wizard?
    self.is_master_wizard || self.is_wizard ? true : false
  end
  alias_method :is_admin?, :is_wizard?
  alias_method :admin?, :is_wizard?
  alias_method :admin, :is_wizard?
  
  def is_master?
    self.is_master_wizard ? true : false
  end
  alias_method :master?, :is_master?


  def name
    "#{first_name} #{last_name}".strip
  end
  
  def full_name
    build_name
  end
  
  
  # http://stackoverflow.com/questions/26623980/user-authentication-with-grape-and-devise
  def ensure_authentication_token
    self.api_auth_token ||= generate_authentication_token
  end


  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
  private
    
    def build_user_settings
      self.build_setting unless self.setting
    end
    
    def check_for_changes
      self.first_name = self.first_name.to_s.strip.capitalize if self.first_name_changed?
      self.last_name = self.last_name.to_s.strip.capitalize if self.last_name_changed?
    end
    
    def generate_authentication_token
      begin
        # => token = Devise.friendly_token
        token = Digest::SHA1.hexdigest SecureRandom.hex
      end while User.where(api_auth_token: token).exists?
      token
    end
    
    def build_name( style = :full, polite = false )
      style     = [:short, "short"].include?(style) ? "short" : "full"
      fname     = style == "short" ? "#{self.first_name.to_s[0]}." : "#{self.first_name}"
      fullname  = []
      fullname << I18n.t("polite_salutation.#{style}.#{self.gender}")   if !self.gender.blank? && polite
      fullname << fname.titleize                                        if !self.first_name.blank?
      
      if self.last_name && !self.last_name.blank?
        if (self.last_name.split(" ").count > 1)
          self.last_name.split(" ").each do |nm|
            nm[0] = nm[0].upcase
            fullname << nm
          end
        else
          nm = self.last_name
          nm[0] = nm[0].upcase
          fullname << nm
        end
      end
      fullname.join(' ')
    end
  
  
end
