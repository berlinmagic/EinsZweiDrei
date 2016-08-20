# encoding: utf-8
class AddMagicLocales < ActiveRecord::Migration
  def up
    
    #
    ## Locales
    create_table :mgclang_locales do |t|
      # t.string      :name
      t.string      :natural_name
      t.string      :iso_code
      t.string      :locale_state,    default: "inactive"
      t.timestamps
    end
    
    add_index :mgclang_locales, :iso_code, unique: true
    
    MagicLocales::Locale.create_translation_table! :name => :string
    
    
    #
    ## (spoken) Languages
    create_table :mgclang_languages do |t|
      t.string        :level
      t.boolean       :default,    default: false
      t.references    :owner,      polymorphic: true
      t.references    :locale
      t.timestamps
    end
    
    add_index :mgclang_languages, [:owner_type, :owner_id]
    add_index :mgclang_languages, :locale_id
    
    
    #
    ## seed default Locales
    load "#{ Rails.root }/db/seed_locales.rb"
    
    
  end
  def down
    
    ## Addresses
    remove_index  :mgclang_locales, :iso_code
    drop_table    :mgclang_locales
    MagicAddresses::Address.drop_translation_table!
    
    
    remove_index  :mgclang_languages, :locale_id
    remove_index  :mgclang_languages, [:owner_type, :owner_id]
    drop_table    :mgclang_languages
    
  end
end
