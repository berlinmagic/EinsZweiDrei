# encoding: utf-8
module InitialsGenerator
  extend ActiveSupport::Concern
  
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  # => C L A S S - M E T H O D S
  module ClassMethods
    
    def has_user_image
      send :include, InstanceMethods
      ## include image functionality
      dragonfly_accessor :image do
        default "#{ Rails.root }/app/assets/images/fallbacks/user.jpg"
        after_unassign :generate_initials!
      end
      ## check if action is needed
      before_validation :create_initials_if_needed
    end
    
    def has_company_image
      send :include, InstanceMethods
      ## include image functionality
      dragonfly_accessor :image do
        default "#{ Rails.root }/app/assets/images/fallbacks/company.jpg"
        after_unassign :generate_initials!
      end
      ## check if action is needed
      before_validation :create_initials_if_needed
    end
    
  end
  
  # => I N S T A N C E - M E T H O D S
  module InstanceMethods
    
    
    ## Avatar - Methods
    def has_initials?
      self.image_name.to_s == "initials.png"
    end
    
    def has_image?
      self.image_stored?
    end
    
    def get_image_url( size = 100 )
      self.image.thumb("#{size}x#{size}#").url()
    end
    
    def image_50
      render_sized_image(50)
    end
    def image_100
      render_sized_image(100)
    end
    def image_200
      render_sized_image(200)
    end
    def render_sized_image(size)
      self.image.thumb("#{size.to_i}x#{size.to_i}#").url()
    end
    
    def avatar_url
      get_image_url( 120 )
    end
    alias_method :logo_url, :avatar_url
    
    
    private
      
      def create_initials_if_needed
        generate_initials unless self.image_url.present?
      end
      
      def generate_initials
        # generate new initials if needed
        if self.respond_to?(:first_name) && self.respond_to?(:last_name)
          if (self.first_name.present? && self.last_name.present?) && ((!self.image_stored? && !self.image_changed?) || ((self.first_name_changed? || self.last_name_changed?) && self.has_initials?))
            generate_initials!
          end
        else
          if self.name.present? && ((!self.image_stored? && !self.image_changed?) || ((self.name_changed?) && self.has_initials?))
            generate_initials!
          end
        end
      end
      
      def generate_initials_and_save
        generate_initials!
        save
      end
      
      def generate_initials!
        app = Dragonfly.app
        if self.respond_to?(:first_name) && self.respond_to?(:last_name)
          image_text = "#{self.first_name.to_s.firstletter}#{self.last_name.to_s.firstletter}".strip
        else
          image_text = "#{self.name.to_s.firstletter}".strip
        end
        self.image = app.generate(:square_text, "#{ image_text.blank? ? '?' : image_text }".strip )
      end
      
  end
  
  
end