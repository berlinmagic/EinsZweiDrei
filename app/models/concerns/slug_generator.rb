# encoding: utf-8
module SlugGenerator
  extend ActiveSupport::Concern

  included do
    validates         :slug,          presence: true,     uniqueness: { case_sensitive: false }
    before_validation :fillout_slug
  end

  # instance methods
  private
    
    # generate an uuid of not present
    def fillout_slug
      self.slug = self.name.to_s.url_save if self.name_changed? || self.new_record? || self.slug.blank?
    end


  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods
    # ...
  end

end