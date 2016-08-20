module FormHelper
  
  def error_msg( item )
    if item.errors.any?
      cls = item.class.to_s.parameterize("_")
      headline = I18n.t(  "errors.template.header",
                          count: item.errors.count,
                          model: I18n.t("activerecord.attributes.#{cls}", count: 1) )
      msgs = ""
      item.errors.each do |key, msg|
        if key.to_s.split(".").count > 1
          key = key.to_s.split(".")
          that = "#{I18n.t("activerecord.attributes.#{key[key.count - 2]}", count: 1)}: #{I18n.t("helpers.label.#{key[key.count - 2]}.#{key[key.count - 1]}")}"
        else
          that = I18n.t("helpers.label.#{cls}.#{key}")
        end
        msgs += <<-HTML
                  <li>#{ icon("arrow-right") } <strong>#{ that }</strong> #{ msg }</li>
                HTML
      end
      html = <<-HTML
          <div class="error-box banderole">
            <div class="icn">
              #{ icon("info-round") }
            </div>
            <h4>#{ headline }</h4>
            <ul>
              #{ msgs }
            </ul>
          </div>
      HTML

      html.html_safe
    end
  end
  
  def ctrl_error_messages( item )
    cls = item.class.to_s.parameterize("_")
    # item.errors.map{ |key, msg| "#{key.to_s.split(".").count > 1 ? I18n.t("helpers.label.#{key.to_s.split(".")[key.to_s.split(".").count - 2]}.#{key.to_s.split(".")[key.to_s.split(".").count - 1]}") : I18n.t("helpers.label.#{cls}.#{key}")}: #{msg}" }
    notes = []
    item.errors.each do |key, msg|
      if key.to_s.split(".").count > 1
        key = key.to_s.split(".")
        that = "#{I18n.t("activerecord.attributes.#{key[key.count - 2]}", count: 1)}: #{I18n.t("helpers.label.#{key[key.count - 2]}.#{key[key.count - 1]}")}"
      else
        that = I18n.t("helpers.label.#{cls}.#{key}")
      end
      notes << "#{that} #{msg}"
    end
    notes.join(", ")
  end
  
  
  ## <%= link_to_add_fields( t("settings.profile.add_a_language"), f, :spoken_languages, "backend/settings/forms/spoken_language", class: "btn", target: "foreign_languages") %>
  def link_to_add_fields(name, f, association, path = "", *args)
    dapath = !path.blank? ? path : "#{association.to_s.singularize}_fields"
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(dapath, f: builder)
    end
    options     = args.extract_options!
    options[:class]         = "#{options[:class]} add_fields"
    options[:data]        ||= {}
    options[:data][:id]     = id
    options[:data][:fields] = fields.gsub("\n", "")
    options[:data][:target] = options[:target]
    options[:target] = nil
    # link_to(name, '#', class: "add_fields btn btn-small", data: {id: id, fields: fields.gsub("\n", "")})
    link_to(name, '#', options)
  end
  
  
  def autocomplete_add_fields(name, f, association, path = "", *args)
    dapath = !path.blank? ? path : "#{association.to_s.singularize}_fields"
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(dapath, f: builder)
    end
    options     = args.extract_options!
    options[:class]         = "#{options[:class]} add_fields_field"
    options[:data]        ||= {}
    options[:data][:id]     = id
    options[:data][:fields] = fields.gsub("\n", "")
    options[:data][:target] = options[:target]
    options[:target] = nil
    txt = text_field_tag( "add_fields_autocomplete_fake", "", class: "hidden", name: "add_fields_autocomplete_field" )
    txt += text_field_tag( "add_fields_autocomplete_field", "", options )
    txt
  end
  
  
end
