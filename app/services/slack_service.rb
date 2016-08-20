# encoding: utf-8

require "uri"
require "net/http"

class SlackService
  class << self
    
    def inform( text, type, user_name, image )
      send({ text: "#{ text }", username: "#{ type } - #{ user_name }", icon_url: "#{ image }" })
    end
    
    
    def send( params )
      slack_params = default_params.merge params
      Net::HTTP.post_form(URI.parse('https://slack.com/api/chat.postMessage'), slack_params)
    end
    
    def default_params
      {
            token:      CONFIG[:slack_token],
            channel:    CONFIG[:slack_channel],
            text:       ".. Slack-Message ..",
            parse:      "full",
            mrkdwn:     true,
            username:   ".. Slack-Title ..",
            icon_url:   "http://icons.iconarchive.com/icons/gcds/chinese-new-year/128/orange-icon.png"
      }
    end
    
  end
end