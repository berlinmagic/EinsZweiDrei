## needs at least Rails 4.2.1
require "action_view"
ActionView::Helpers::Tags::Translator.class_eval do
  
  def translate
    translated_attribute = I18n.t("#{object_name}.#{method_and_value}", default: i18n_default, scope: scope).presence
    translated_fallback = I18n.t("#{method_and_value}", default: i18n_default, scope: "helpers.label.defaults").presence
    translated_attribute || translated_fallback || human_attribute_name
  end
  
end