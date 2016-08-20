module ApplicationHelper
  
  def fetch_current_domain
    request.original_url.to_s.split("?")[0]
  end
  
  def icon( icn, txt = "" )
    raw("<i class='icomoon-#{icn}#{" #{txt}" if !txt.blank?}'></i>")
  end
  
  def olicon( icn, txt = "" )
    raw("<i class='olicons-#{icn}#{" #{txt}" if !txt.blank?}'></i>")
  end
  
  def bettericon( icn, txt = "" )
    raw("<i class='bettericon-#{icn}#{" #{txt}" if !txt.blank?}'></i>")
  end
  alias_method :btricn,   :bettericon
  alias_method :btricon,  :bettericon
  
  def app_link
    link_to(CONFIG[:domain], app_root_url)
  end
  
  def app_root_url
    "#{CONFIG[:production][:protocol]}://#{CONFIG[:domain]}"
  end
  
  def full_url_for( path )
    "#{CONFIG[:protocol]}://#{CONFIG[:host]}#{path.to_s.to_slash}"
  end
  
  def strip_domain_from_url( url_sting )
    return "???" unless url_sting.present?
    url_sting.gsub(/https?:\/\/#{CONFIG[:host]}#{':' + CONFIG[:port] unless Rails.env.production? || Rails.env.staging?}/,'')
  end
  
  def avatar( usr, sz = 30, style = "" )
    image_tag( usr.get_image_url(sz.to_i * 2), alt: usr.name, class: "avatar #{style}" )
  end
  
  def image( obj, sz = 30, style = "" )
    image_tag( obj.get_image_url(sz.to_i * 2), alt: obj.name, class: "#{obj.class.to_s == 'User' ? 'avatar' : 'logo'} #{style}" )
  end
  
  def ico_path( ico = "apple-touch-icon" )
    asset_path("favicon/#{ ico }.png")
  end
  
  def t(*args)
    options = args.extract_options!
    key = args.first
    raw( I18n.t(key, options.merge({ app_name: CONFIG[:app_name] })) )
  end
  
  # helper for phrase-app (silent translations)
  def pt(*args)
    if !Rails.env.production? && session && session[:tranlating_mode]
      options = args.extract_options!
      key = args.first
      content_tag :span, I18n.t(key, options.merge({ app_name: CONFIG[:app_name] })), class: "no_view_translation"
    else
      ""
    end
  end
  
  
  def christmas_time?
    Time.now.month == 12 && Time.now.day < 27
  end
  
  def google_font_tag( font, *args )
    options     = args.extract_options!
    html = <<-HTML
        <link href="//fonts.googleapis.com/css?family=#{font}#{'&subset=' + options[:subset] if !options[:subset].blank?}#{'&text=' + options[:text] if !options[:text].blank?}" rel="stylesheet" type="text/css" />
    HTML
    html.html_safe
  end
  
  
end
