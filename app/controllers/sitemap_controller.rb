# encoding: utf-8
#
require 'ox'
#
class SitemapController < ApplicationController
  
  DEFAULTS = {        changed:    CONFIG[:sitemap_last_changed], 
                      changefreq: CONFIG[:sitemap_changefreq], 
                      priority:   CONFIG[:sitemap_priority]           }
  
  
  helper :application
  
  ## render html/txt versions
  def text
    render :sitemap
  end
  
  
  ## render xml version
  def xml
    
    ## Chagefreq:
    # always / hourly / daily / weekly / monthly / yearly / never
    
    doc = Ox::Document.new(:version => '1.0')
    
    root = Ox::Element.new('urlset')
    root[:xmlns] = 'http://www.sitemaps.org/schemas/sitemap/0.9'
    root["xmlns:xhtml"] = "http://www.w3.org/1999/xhtml"
    doc << root
    
    if CONFIG[:internationalize_sitemap]
      
      root = internationalize_url( root, root_path )
      FrontendController::PAGEZ.each do |page|
        root = internationalize_url( root, url_for(page.dasherize) )
      end
      
    else
      
      root << build_url( root_path )
      FrontendController::PAGEZ.each do |page|
        root << build_url( url_for(page.dasherize) )
      end
      
    end
    
    # @xml = Ox.dump(doc, with_xml: true, encoding: 'UTF-8')
    @xml = Ox.dump(doc)
    render :sitemap
  end
  
private
  
  def internationalize_url( root, domain, lastmod = "2014-09-03", changefreq = "monthly", priority = "0.5" )
    root << build_intnational_url( domain, nil, lastmod,   changefreq,   priority )
    system_locales.each do |lcl|
      root << build_intnational_url( domain, lcl, lastmod,   changefreq,   priority )
    end
    root
  end
  
  def build_intnational_url( domain, locale = "de", lastmod = DEFAULTS[:changed], changefreq = DEFAULTS[:changefreq], priority = DEFAULTS[:priority])
    url = Ox::Element.new('url')
    loc = Ox::Element.new('loc')
    loc << url_for( Rails.application.routes.recognize_path( domain ).merge({ only_path: false, locale: locale }) )
    url << loc
    url << build_hreflng_tag( domain, nil )
    system_locales.each do |lcl|
      url << build_hreflng_tag( domain, lcl )
    end
    url
  end
  
  def build_hreflng_tag( domain, locale = nil )
    hrflng = Ox::Element.new('xhtml:link')
    hrflng['rel'] = "alternate"
    hrflng['hreflang'] = locale || 'x-default'
    hrflng['href'] = "#{ url_for( Rails.application.routes.recognize_path( domain ).merge({only_path: false, locale: locale}) ) }"
    hrflng
  end
  
  def build_url( domain, lastmod = DEFAULTS[:changed], changefreq = DEFAULTS[:changefreq], priority = DEFAULTS[:priority])
    url = Ox::Element.new('url')
    loc = Ox::Element.new('loc')
    # loc << "#{domain}"
    loc << url_for( Rails.application.routes.recognize_path( domain ).merge({ only_path: false, locale: nil }) )
    url << loc
    if !lastmod.blank?
      mod = Ox::Element.new('lastmod')
      mod << lastmod
      url << mod
    end
    if !changefreq.blank?
      freq = Ox::Element.new('changefreq')
      freq << changefreq
      url << freq
    end
    if !priority.blank?
      prio = Ox::Element.new('priority')
      prio << priority
      url << prio
    end
    url
  end
  
  def build_prct_url( prdct )
    url = Ox::Element.new('url')
    loc = Ox::Element.new('loc')
    loc << full_url_for( prdct.full_slug )
    url << loc
    mod = Ox::Element.new('lastmod')
    mod << prdct.updated_at.strftime("%Y-%m-%d")
    url << mod
    freq = Ox::Element.new('changefreq')
    freq << "monthly"
    url << freq
    prio = Ox::Element.new('priority')
    prio << "0.7"
    url << prio
    url
  end
  
  def full_url_for( path )
    "#{CONFIG[:protocol]}://#{CONFIG[:host]}#{path.to_s.to_slash}"
  end
  
end
