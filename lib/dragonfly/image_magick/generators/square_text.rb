# encoding: utf-8
# Initials TextGenerator for dragonfly by twetzel
# Generates an Images for 
# 
# Usage:
#   app = Dragonfly.app
#   app.generate(:square_text, "AB" )
#   app.generate(:square_text, "CD", "background" => "#a0c775" )
#   app.generate(:square_text, "FG", "background" => "#a0c775", "font_family" => "Courier" )
#   ...


require 'dragonfly/hash_with_css_style_keys'

module Dragonfly
  module ImageMagick
    module Generators
      class SquareText

        FONT_STYLES = Dragonfly::ImageMagick::Generators::Text::FONT_STYLES
        FONT_STRETCHES = Dragonfly::ImageMagick::Generators::Text::FONT_STRETCHES
        FONT_WEIGHTS = Dragonfly::ImageMagick::Generators::Text::FONT_WEIGHTS

        def update_url(url_attributes, string, opts={})
          url_attributes.name = "text.#{extract_format(opts)}"
        end

        def call(content, string, opts={})
          opts            = HashWithCssStyleKeys[opts]
          args            = []
          format          = extract_format(opts)
          escaped_string  = "\"#{string.gsub(/"/, '\"')}\""
          # set font:
          font_family     = opts['font_family'] || 'Helvetica'
          font_weight     = FONT_WEIGHTS[opts['font_weight']] || 700
          # set colors:
          # background      = opts['background'] || random_color
          background      = opts['background'] || random_pastel_color
          font_color      = opts['color'] || get_font_color(background)
          # set sizes:
          size            = ( opts['width'] || 600 ).to_i
          font_size       = ( opts['font_size'] || generate_font_size(size, string) ).to_i
          
          # push Settings
          args.push("-gravity Center")
          args.push("-antialias")
          args.push("-pointsize #{font_size}")
          args.push("-family '#{font_family}'")
          args.push("-fill '#{font_color}'")
          args.push("-stroke #{opts['stroke_color']}") if opts['stroke_color']
          args.push("-style #{FONT_STYLES[opts['font_style']]}") if opts['font_style']
          args.push("-stretch #{FONT_STRETCHES[opts['font_stretch']]}") if opts['font_stretch']
          args.push("-weight #{font_weight}")
          args.push("-background #{background}")
          args.push("label:#{escaped_string}")
          
          content.generate!(:convert, args.join(' '), format)
          
          # dimensions = content.analyse(:image_properties)
          # text_width  = dimensions['width']
          # text_height = dimensions['height']
          
          # Rails.logger.info "ARGS: #{args.to_yaml}"
          args = args.slice(0, args.length - 2)
          # Rails.logger.info "ARGS: #{args.to_yaml}"
          
          args.push("-size #{size}x#{size}")
          args.push("xc:#{background}")
          
          # push a little down, so capital text apears more centered
          args.push("-annotate 0x0+0+#{ (font_size / 9).to_i } #{escaped_string}")
          
          content.generate!(:convert, args.join(' '), format)
          content.add_meta('format' => format, 'name' => "initials.#{format}")
        end

        ## 
        ## color related helper methods
        ## also usable via:
        ## ::Dragonfly::ImageMagick::Generators::SquareText.method()
        ## 
        class << self
          
          def compare_colors(bg = "#fff", fg = "#000")
            # capture comand (stdout, stderror, status)
            o, e, s = Open3.capture3("compare -metric RMSE xc:'#{bg}' xc:'#{fg}' null:")
            if Rails.env.development?
              puts "***************************************"
              puts "$ compare -metric RMSE xc:'#{bg}' xc:'#{fg}' null:"
              puts "stdout: #{o}"
              puts "stderr: #{e}"
              puts "status: #{s}"
              puts "***************************************"
            end
            # output comes via standard error 
            # fetch percentage from output e.g. "48520.2 (0.74037)" => 0.74037 %
            if e == "65535 (1)"
              e = compare_hex( bg, fg )
            else
              e = e.match(/.*\((.*)\).*/)[1] if e.match(/.*\((.*)\).*/)
            end 
            return e
          end
          
          ## http://stackoverflow.com/a/9733420/1470996
          def luminance( clr )
            clr = rgb_from_hex( clr ) unless clr.kind_of?(Array)
            res = clr.map do |this|
              this = this / 255.0
              if this <= 0.03928
                this / 12.92
              else
                (( this + 0.055 ) / 1.055) ** 2.4
              end
            end
            return res[0] * 0.2126 + res[1] * 0.7152 + res[2] * 0.0722
          end
          
          def compare_rgb(bg, fg)
            bg = (299 * bg[0] + 587 * bg[1] + 114 * bg[2]) / 1000
            fg = (299 * fg[0] + 587 * fg[1] + 114 * fg[2]) / 1000
            (bg > fg ? bg - fg : fg - bg).to_f / 255.0
          end

          def compare_hex( bg, fg )
            bg = rgb_from_hex( bg )
            fg = rgb_from_hex( fg )
            compare_rgb( bg, fg )
          end
          
          def compare_luminance(bg, fg)
            bg = luminance( bg ) + 0.05
            fg = luminance( fg ) + 0.05
            bg > fg ? bg / fg : fg / bg
          end
          
          def compare_clr_luminance(bg, fg)
            bg = bg + 0.05
            fg = fg + 0.05
            bg > fg ? bg / fg : fg / bg
          end

          def rgb_from_hex( hex )
            hex = hex.split("")
            hex.shift if hex.index("#") == 0
            cnt = (hex.length == 3 ? 1 : 2)
            rgb = []
            3.times do |x|
              that = hex.shift(cnt).join
              rgb << "#{that * (cnt == 2 ? 1 : 2)}".to_i(16)
            end
            rgb
          end

          def readable_color( clr )
            ## higher than 4.5 for good contrast
            ## higher than 7 for real great contrast
            # if great_contrast_color( clr )
            #   great_contrast_color( clr )
            # else
            #   good_contrast_color( clr )
            # end
            lum = luminance( clr )
            if compare_clr_luminance( lum, 1.0 ) > compare_clr_luminance( lum, 0.0 )
              "#fff"
            else
              "#000"
            end
          end
          
          def great_contrast_color( clr )
            return "#000" if compare_luminance(clr, "#000") > 7.0
            return "#fff" if compare_luminance(clr, "#fff") > 7.0
            false
          end
          
          def good_contrast_color( clr )
            if compare_luminance(clr, "#000") > 4.5
              "#000"
            else
              "#fff"
            end
          end

          def random_color
            "##{ 3.times.map{ (rand(255) ).to_s(16).rjust(2,"0") }.join }"
          end

          def random_pastel_color
            "##{ 3.times.map{ (rand(92) + 152 ).to_s(16).rjust(2,"0") }.join }"
          end
          
        end #eoc


        private
          
          def extract_format(opts)
            opts['format'] || 'png'
          end
          
          def generate_font_size(size, string)
            # generate font size, max half of size
            sz = string.length > 1 ? (size / string.length).to_i : (size / 2).to_i
            (sz * 0.8).to_i
          end
          
          def get_font_color(background)
            self.class.readable_color( background )
          end
          
          def random_color
            self.class.random_color()
          end
          
          def random_pastel_color
            self.class.random_pastel_color()
          end
          
          def compare_colors(bg = "#fff", fg = "#000")
            self.class.compare_colors( bg, fg )
          end

      end

    end
  end
end