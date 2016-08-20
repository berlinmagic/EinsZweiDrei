# encoding: utf-8

puts "MagicLocales seed default locales"

ML_SYSTEM_LOCALES  = %w(cs de en it pl ru)

ML_MAGIC_LOCALES =  {
  "bg" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Bulgarian"}, 
      {:locale=>"cs", :name=>"bulharština"}, 
      {:locale=>"de", :name=>"Bulgarisch"}, 
      {:locale=>"es", :name=>"Búlgaro"}, 
      {:locale=>"fr", :name=>"bulgare"}, 
      {:locale=>"it", :name=>"Bulgaro"}, 
      {:locale=>"pl", :name=>"bułgarski"}, 
      {:locale=>"ru", :name=>"болгарский"}
    ], 
    "natural_name"=>"Български"
  }, 
  "cs" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Czech"}, 
      {:locale=>"cs", :name=>"čeština"}, 
      {:locale=>"de", :name=>"Tschechisch"}, 
      {:locale=>"es", :name=>"Checo"}, 
      {:locale=>"fr", :name=>"tchèque"}, 
      {:locale=>"it", :name=>"Ceco"}, 
      {:locale=>"pl", :name=>"czeski"}, 
      {:locale=>"ru", :name=>"чешский"}
    ], 
    "natural_name"=>"čeština"
  }, 
  "da" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Danish"}, 
      {:locale=>"cs", :name=>"dánština"}, 
      {:locale=>"de", :name=>"Dänisch"}, 
      {:locale=>"es", :name=>"Danés"}, 
      {:locale=>"fr", :name=>"danois"}, 
      {:locale=>"it", :name=>"Danese"}, 
      {:locale=>"pl", :name=>"duński"}, 
      {:locale=>"ru", :name=>"датский"}
    ], 
    "natural_name"=>"dansk"
  }, 
  "nl" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Dutch"}, 
      {:locale=>"cs", :name=>"nizozemština"}, 
      {:locale=>"de", :name=>"Niederländisch"}, 
      {:locale=>"es", :name=>"Holandés, Flamenco"}, 
      {:locale=>"fr", :name=>"néerlandais"}, 
      {:locale=>"it", :name=>"Olandese"}, 
      {:locale=>"pl", :name=>"holenderski"}, 
      {:locale=>"ru", :name=>"голландский"}
    ], 
    "natural_name"=>"Nederlands"
  }, 
  "en" => {
    "natural_name"=>"English", 
    "translations_attributes"=>[
      {:locale=>"en", :name=>"English"}, 
      {:locale=>"cs", :name=>"angličtina"}, 
      {:locale=>"de", :name=>"Englisch"}, 
      {:locale=>"es", :name=>"Inglés"}, 
      {:locale=>"fr", :name=>"anglais"}, 
      {:locale=>"it", :name=>"Inglese"}, 
      {:locale=>"pl", :name=>"angielski"}, 
      {:locale=>"ru", :name=>"английский"}
    ]
  }, 
  "fi" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Finnish"}, 
      {:locale=>"cs", :name=>"finština"}, 
      {:locale=>"de", :name=>"Finnisch"}, 
      {:locale=>"es", :name=>"Finés"}, 
      {:locale=>"fr", :name=>"finnois"}, 
      {:locale=>"it", :name=>"Finlandese"}, 
      {:locale=>"pl", :name=>"fiński"}, 
      {:locale=>"ru", :name=>"финский"}
    ], 
    "natural_name"=>"suomi"
  }, 
  "fr" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"French"}, 
      {:locale=>"cs", :name=>"francouzština"}, 
      {:locale=>"de", :name=>"Französisch"}, 
      {:locale=>"es", :name=>"Francés"}, 
      {:locale=>"fr", :name=>"français"}, 
      {:locale=>"it", :name=>"Francese"}, 
      {:locale=>"pl", :name=>"francuski"}, 
      {:locale=>"ru", :name=>"французский"}
    ], 
    "natural_name"=>"français"
  }, 
  "de" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"German"}, 
      {:locale=>"cs", :name=>"němčina"}, 
      {:locale=>"de", :name=>"Deutsch"}, 
      {:locale=>"es", :name=>"Alemán"}, 
      {:locale=>"fr", :name=>"allemand"}, 
      {:locale=>"it", :name=>"Tedesco"}, 
      {:locale=>"pl", :name=>"niemiecki"}, 
      {:locale=>"ru", :name=>"немецкий"}
    ], 
    "natural_name"=>"Deutsch"
  }, 
  "el" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Greek, Modern (1453-)"}, 
      {:locale=>"cs", :name=>"řečtina, moderní (1453-)"}, 
      {:locale=>"de", :name=>"Neugriechisch (ab 1453)"}, 
      {:locale=>"es", :name=>"Griego Moderno (>1453)"}, 
      {:locale=>"fr", :name=>"grec moderne (après 1453)"}, 
      {:locale=>"it", :name=>"Greco moderno (1453-)"}, 
      {:locale=>"pl", :name=>"grecki współczesny (1453-)"}, 
      {:locale=>"ru", :name=>"греческий (с 1453)"}
    ], 
    "natural_name"=>"Ελληνικά"
  }, 
  "hr" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Croatian"}, 
      {:locale=>"cs", :name=>"chorvatština"}, 
      {:locale=>"de", :name=>"Kroatisch"}, 
      {:locale=>"es", :name=>"Croata"}, 
      {:locale=>"fr", :name=>"croate"}, 
      {:locale=>"it", :name=>"Croato"}, 
      {:locale=>"pl", :name=>"chorwacki"}, 
      {:locale=>"ru", :name=>"хорватский"}
    ], 
    "natural_name"=>"hrvatski"
  }, 
  "hu" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Hungarian"}, 
      {:locale=>"cs", :name=>"maďarština"}, 
      {:locale=>"de", :name=>"Ungarisch"}, 
      {:locale=>"es", :name=>"Húngaro"}, 
      {:locale=>"fr", :name=>"hongrois"}, 
      {:locale=>"it", :name=>"Ungherese"}, 
      {:locale=>"pl", :name=>"węgierski"}, 
      {:locale=>"ru", :name=>"венгерский"}
    ], 
    "natural_name"=>"magyar"
  }, 
  "it" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Italian"}, 
      {:locale=>"cs", :name=>"italština"}, 
      {:locale=>"de", :name=>"Italienisch"}, 
      {:locale=>"es", :name=>"Italiano"}, 
      {:locale=>"fr", :name=>"italien"}, 
      {:locale=>"it", :name=>"Italiano"}, 
      {:locale=>"pl", :name=>"włoski"}, 
      {:locale=>"ru", :name=>"итальянский"}
    ], 
    "natural_name"=>"Italiano"
  }, 
  "pl" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Polish"}, 
      {:locale=>"cs", :name=>"polština"}, 
      {:locale=>"de", :name=>"Polnisch"}, 
      {:locale=>"es", :name=>"Polaco"}, 
      {:locale=>"fr", :name=>"polonais"}, 
      {:locale=>"it", :name=>"Polacco"}, 
      {:locale=>"pl", :name=>"polski"}, 
      {:locale=>"ru", :name=>"польский"}
    ], 
    "natural_name"=>"polski"
  }, 
  "pt" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Portuguese"}, 
      {:locale=>"cs", :name=>"portugalština"}, 
      {:locale=>"de", :name=>"Portugiesisch"}, 
      {:locale=>"es", :name=>"Portugués"}, 
      {:locale=>"fr", :name=>"portugais"}, 
      {:locale=>"it", :name=>"Portoghese"}, 
      {:locale=>"pl", :name=>"portugalski"}, 
      {:locale=>"ru", :name=>"португальский"}
    ], 
    "natural_name"=>"Português"
  }, 
  "ru" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Russian"}, 
      {:locale=>"cs", :name=>"ruština"}, 
      {:locale=>"de", :name=>"Russisch"}, 
      {:locale=>"es", :name=>"Ruso"}, 
      {:locale=>"fr", :name=>"russe"}, 
      {:locale=>"it", :name=>"Russo"}, 
      {:locale=>"pl", :name=>"rosyjski"}, 
      {:locale=>"ru", :name=>"русский"}
    ], 
    "natural_name"=>"русский"
  }, 
  "es" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Spanish"}, 
      {:locale=>"cs", :name=>"španělština"}, 
      {:locale=>"de", :name=>"Spanisch (Kastilisch)"}, 
      {:locale=>"es", :name=>"Español"}, 
      {:locale=>"fr", :name=>"castillan"}, 
      {:locale=>"it", :name=>"Spagnolo"}, 
      {:locale=>"pl", :name=>"hiszpański"}, 
      {:locale=>"ru", :name=>"испанский"}
    ], 
    "natural_name"=>"Español"
  }, 
  "sv" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Swedish"}, 
      {:locale=>"cs", :name=>"švédština"}, 
      {:locale=>"de", :name=>"Schwedisch"}, 
      {:locale=>"es", :name=>"Sueco"}, 
      {:locale=>"fr", :name=>"suédois"}, 
      {:locale=>"it", :name=>"Svedese"}, 
      {:locale=>"pl", :name=>"szwedzki"}, 
      {:locale=>"ru", :name=>"шведский"}
    ], 
    "natural_name"=>"Svenska"
  }, 
  "uk" => {
    "translations_attributes"=>[
      {:locale=>"en", :name=>"Ukrainian"}, 
      {:locale=>"cs", :name=>"ukrajinština"}, 
      {:locale=>"de", :name=>"Ukrainisch"}, 
      {:locale=>"es", :name=>"Ukranio"}, 
      {:locale=>"fr", :name=>"ukrainien"}, 
      {:locale=>"it", :name=>"Ucraino"}, 
      {:locale=>"pl", :name=>"ukraiński"}, 
      {:locale=>"ru", :name=>"украинский"}
    ], 
    "natural_name"=>"українська"
  }
}


ML_MAGIC_LOCALES.each do |key, params|
  l_state = ML_SYSTEM_LOCALES.include?( key.to_s ) ? 'active' : 'inactive'
  l_state = "live" if key.to_s == I18n.default_locale.to_s
  MagicLocales::Locale.create!(   params.merge({ iso_code: key.to_s, locale_state: l_state })   )
end


puts "MagicLocales finished #{MagicLocales::Locale.all.count} locales"

