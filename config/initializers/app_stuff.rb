##
## Load APP stuff .. extensions, helpers, ...
##

# load controller helper
Dir.glob("#{Rails.root}/lib/helper/*.rb").each do |file|
  require "#{ file.gsub(/\.rb$/, "") }"
end

# load letter_opener patch
require "#{Rails.root}/lib/letter_opener/message"

## Patches and Extensions
Dir.glob("#{Rails.root}/lib/ext/*.rb").each do |file|
  require "#{ file.gsub(/\.rb$/, "") }"
end

if Rails.env.development?
  ## google SSL error
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end