# encoding: utf-8
class Wizard::SubscriptionsController < Wizard::BaseController
  
  def index
    @subscriptions = ::Subscription.order(created_at: :desc).all
  end
  
  def show
    @subscription = ::Subscription.find( params[:id] )
  end
  
  
end
