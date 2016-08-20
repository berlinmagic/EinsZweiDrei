class CreateSubscriptions < ActiveRecord::Migration
  def change
    
    create_table :subscriptions do |t|
      t.string      :email
      t.boolean     :newsletter
      t.boolean     :dev_news
      t.references  :user
      t.string      :user_ip
      t.timestamps  null: false
    end
    
    add_index :subscriptions, :email
    add_index :subscriptions, :user_id
    
  end
end
