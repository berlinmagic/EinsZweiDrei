module ColorHelper

  def luminance( clr )
    ::Dragonfly::ImageMagick::Generators::SquareText.luminance( clr )
  end
  
  def compare_luminance( bg, fg )
    ::Dragonfly::ImageMagick::Generators::SquareText.compare_luminance( bg, fg )
  end
  
  def compare_hex( bg, fg )
    ::Dragonfly::ImageMagick::Generators::SquareText.compare_hex( bg, fg )
  end
  
  def rgb_from_hex( hex )
    ::Dragonfly::ImageMagick::Generators::SquareText.rgb_from_hex( hex )
  end
  
  def readable_color( clr )
    ::Dragonfly::ImageMagick::Generators::SquareText.readable_color( clr )
  end
  
  def random_color
    ::Dragonfly::ImageMagick::Generators::SquareText.random_color()
  end
  
  def random_pastel_color
    ::Dragonfly::ImageMagick::Generators::SquareText.random_pastel_color()
  end

end