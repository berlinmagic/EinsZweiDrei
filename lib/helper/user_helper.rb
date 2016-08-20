# encoding: utf-8
module UserHelper
  module InstanceMethods
    
    
    private
    
    ##  U S E R - S T U F F   = = = = = = = = = = = = = = = = = = = = = = = = = = = 
    
    def master_wizard?
      current_user ? current_user.is_master? : false
    end
    alias_method :super_admin?, :master_wizard?
    
    def wizard?
      return false unless current_user
      return true if current_user.is_master?
      return true if current_user.is_wizard?
      false
    end
    alias_method :admin?, :wizard?
    
  end

  def self.included(receiver)
    #receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
    
    receiver.send :helper_method, :wizard?, :master_wizard?
    receiver.send :helper_method, :admin?, :super_admin?
    
  end
  
end