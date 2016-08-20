# encoding: utf-8
module MainHelper
  module InstanceMethods
    
    # can be used in views as well as controllers.
    # e.g. <% title = 'This is a custom title for this view' %>
    attr_writer :title
    attr_writer :meta_keywords
    attr_writer :meta_description
    
  protected
    
    def db_adapter
      @db_adapter ||= get_db_adapter
    end
    
    def get_db_adapter
      ActiveRecord::Base.connection.class.name.to_s.match(/^ActiveRecord::ConnectionAdapters::(.*)Adapter$/)[1]
    end
    
    def default_title
      CONFIG[:app_name]
    end
  
    # this is a hook for subclasses to provide title
    def accurate_title
      nil
    end
    
    def accurate_meta_keywords
      # CONFIG[:app_name]
      keywords = []
      if I18n.t("seo.keywords")
        if I18n.t("seo.keywords").respond_to?(:join)
          I18n.t("seo.keywords").map{ |kw| keywords << kw }
        else
          keywords << I18n.t("seo.keywords")
        end
      end
      keywords.join(",")
    end
    
    def accurate_meta_description
      # nil
      I18n.t( "seo.description", app_name: CONFIG[:app_name] ) if I18n.t("seo.description")
    end
    
  private
    
    def title
      title_string = @title.present? ? @title : accurate_title
      if title_string.present?
        if CONFIG[:app_name_in_title] == 'before'
          [ default_title, CONFIG[:title_seperator], title_string ].join(' ')
        elsif CONFIG[:app_name_in_title] == 'after'
          [ title_string, CONFIG[:title_seperator], default_title ].join(' ')
        else
          title_string
        end
      else
        default_title
      end
    end
    
    def meta_keywords
      @meta_keywords ? @meta_keywords : accurate_meta_keywords
    end
    
    def meta_description
      @meta_description ? @meta_description : accurate_meta_description
    end
    
    
  end

  def self.included(receiver)
    #receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
    
    receiver.send :helper_method, :title
    receiver.send :helper_method, :db_adapter
    receiver.send :helper_method, :title=
    receiver.send :helper_method, :meta_keywords, :meta_description
    
  end
  
end