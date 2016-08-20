module PartialHelper
  
  # => http://www.igvita.com/2007/03/15/block-helpers-and-dry-views-in-rails/
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    #concat(render(:partial => partial_name, :locals => options), block.binding)
    render(:partial => partial_name, :locals => options)
  end
  
  # def devise_mail_wrapper(options = {}, &block)
  #   block_to_partial('shared/templates/devise_mailer', options, &block)
  # end
  
  
end
