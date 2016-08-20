# encoding: utf-8
class Wizard::PagesController < Wizard::BaseController
  
  CONFIDENTIALS = [ "monit", "sidekiq" ]
  CONFIDENTIAL_PATHES = {
    "monit"     =>  "https://#{CONFIG[:monit_username]}:#{CONFIG[:monit_password]}@servicehub.cloudapp.net:2812/",
    "sidekiq"   =>  "/admin/sidekiq/"
  }
  
  def dashboard
    
    @dayz = 42
    
    ## for SQLit3
    if db_adapter == "SQLite3"
      
      @user_signups = User.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
        sum( CASE WHEN signup_via = 'app' THEN 1 ELSE 0 END) as app,
        sum( CASE WHEN signup_via = 'google' THEN 1 ELSE 0 END) as google,
        sum( CASE WHEN signup_via = 'facebook' THEN 1 ELSE 0 END) as facebook,
        sum( CASE WHEN signup_via = 'seed' THEN 1 ELSE 0 END) as seed,
        count(*) as count,
        strftime('%d', created_at) as day, strftime('%m', created_at) as month, strftime('%Y', created_at) as year
      ").group("year", "month", "day").order("year", "month", "day")
      
      @done_feedbacks = Feedback.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
        sum( CASE WHEN subject = 'feature' THEN 1 ELSE 0 END) as feature,
        sum( CASE WHEN subject = 'bug' THEN 1 ELSE 0 END) as bug,
        sum( CASE WHEN subject = 'contact' THEN 1 ELSE 0 END) as contact,
        count(*) as count,
        strftime('%d', created_at) as day, strftime('%m', created_at) as month, strftime('%Y', created_at) as year
      ").group("year", "month", "day").order("year", "month", "day")
      
      @done_subscriptions = Subscription.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
        count(*) as count,
        strftime('%d', created_at) as day, strftime('%m', created_at) as month, strftime('%Y', created_at) as year
      ").group("year", "month", "day").order("year", "month", "day")
      
    elsif db_adapter == "PostgreSQL"
      
      @user_signups = User.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
        SUM( CASE WHEN signup_via SIMILAR TO 'app' THEN 1 ELSE 0 END) as app,
        SUM( CASE WHEN signup_via SIMILAR TO 'google' THEN 1 ELSE 0 END) as google,
        SUM( CASE WHEN signup_via SIMILAR TO 'facebook' THEN 1 ELSE 0 END) as facebook,
        SUM( CASE WHEN signup_via SIMILAR TO 'seed' THEN 1 ELSE 0 END) as seed,
        count(*) as count,
        extract(day from created_at) as day, extract(month from created_at) as month, extract(year from created_at) as year
      ").group("year", "month", "day").order("year", "month", "day")
      
      @done_feedbacks = Feedback.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
        SUM( CASE WHEN subject SIMILAR TO 'feature' THEN 1 ELSE 0 END) as feature,
        SUM( CASE WHEN subject SIMILAR TO 'bug' THEN 1 ELSE 0 END) as bug,
        SUM( CASE WHEN subject SIMILAR TO 'contact' THEN 1 ELSE 0 END) as contact,
        count(*) as count,
        extract(day from created_at) as day, extract(month from created_at) as month, extract(year from created_at) as year
      ").group("year", "month", "day").order("year", "month", "day")
      
      @done_subscriptions = Subscription.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
        count(*) as count,
        extract(day from created_at) as day, extract(month from created_at) as month, extract(year from created_at) as year
      ").group("year", "month", "day").order("year", "month", "day")
      
    end
    
    @user_sources = User.unscoped.where("created_at > ?", Time.zone.parse((Date.today - @dayz.days).to_s) ).select("
      signup_url,
      count(*) as count
    ").group("signup_url").order("count DESC")
    
    
  end
  
  def verify
    @that = params[:that]
    @verification = { that: @that, password: nil }
  end
  
  def styles
    
  end
  
  def verify_that
    if verification_params[:company_password].present? && verification_params[:company_password] == CONFIG[:company_pass]
      render_confidential_path( verification_params[:that] )
    else
      redirect_to admin_root_path, alert: "That was not correct! .. Go away!"
    end
  end
  
private
  
  def render_confidential_path( pth )
    pth = pth.strip.downcase
    if CONFIDENTIALS.include?( pth )
      redirect_to CONFIDENTIAL_PATHES[ pth ]
    else
      redirect_to admin_root_path, alert: "Path not found .. maybe Link is broken :("
    end
  end
  
  def verification_params
    params.require(:verification).permit( :that, :company_password )
  end
  
end
