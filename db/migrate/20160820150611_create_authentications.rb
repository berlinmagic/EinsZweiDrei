class CreateAuthentications < ActiveRecord::Migration
  def change
    
    create_table :authentications do |t|
      t.string        :email
      t.string        :uid
      t.string        :provider
      t.string        :link
      t.references    :user
      t.timestamps    null: false
    end
    
    add_index       :authentications, :user_id
    add_index       :authentications, :uid
    
  end
end
