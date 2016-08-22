require 'dragonfly'
require "#{Rails.root}/lib/dragonfly/image_magick/generators/square_text"

# Logger
Dragonfly.logger = Rails.logger

# Variables
if Rails.env.production?
  drgnfly_convert    = "/usr/bin/convert"
  drgnfly_datastore  = '/home/azureuser/EinsZweiDrei-production/shared/dragonfly'
elsif Rails.env.staging?
  drgnfly_convert    = "/usr/bin/convert"
  drgnfly_datastore  = '/home/azureuser/EinsZweiDrei-staging/shared/dragonfly'
else
  drgnfly_convert    = "/usr/local/bin/convert"
  drgnfly_datastore  = Rails.root.join('public/system/dragonfly', Rails.env)
end

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  verify_urls true
  secret "ab1e2856d4d5684e60df3791f248d3f0f18be603a7739f37dd1f4a5493c90b23"

  url_format "/media/:job.:ext"
  # => url_format "/media/:job/:name"
  
  datastore :file, root_path: drgnfly_datastore
  
  processor :rounded do |content, size|
    content.shell_update ext: 'png' do |old_path, new_path|
      "#{drgnfly_convert} #{old_path} -alpha set -background none -thumbnail #{size}^ -vignette 0x0 #{new_path}"
    end
  end
  processor :squared do |content, size|
    content.shell_update ext: 'png' do |old_path, new_path|
      "#{drgnfly_convert} #{old_path} -thumbnail #{ size.gsub(/#/,">") } -background none -gravity center -extent #{size} #{new_path}"
    end
  end
  
  processor :retina_sharped do |content|
    content.process!(:convert, "-set colorspace sRGB -strip -sharpen 0x0.5")
  end
  
  processor :retina_jpg do |content, size|
    # convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg
    # mogrify -quality "97%" -resize 2048x2048 -filter Lanczos -interlace Plane -gaussian-blur 0.05 
    content.shell_update ext: 'jpg' do |old_path, new_path|
      "#{drgnfly_convert} #{old_path} -thumbnail #{ size.gsub(/#/,">") } -quality 80% -set colorspace sRGB -strip -sharpen 0x0.5 #{new_path}"
    end
  end
  
  processor :retina do |content|
    # convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg
    # mogrify -quality "97%" -resize 2048x2048 -filter Lanczos -interlace Plane -gaussian-blur 0.05 
    content.shell_update ext: 'jpg' do |old_path, new_path|
      # "#{drgnfly_convert} #{old_path} -quality 30% -set colorspace sRGB -strip -sharpen 0x0.5 #{new_path}"
      "#{drgnfly_convert} #{old_path} -background white -alpha remove -quality 80% -set colorspace sRGB -strip -sharpen 0x0.5 #{new_path}"
    end
  end
  
end

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end


Dragonfly.app.add_generator :square_text, Dragonfly::ImageMagick::Generators::SquareText.new


