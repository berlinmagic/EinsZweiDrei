class CreateQuestions < ActiveRecord::Migration
  def change
    
    create_table :questions do |t|
      t.integer     :position
      
      t.text        :text
      t.string      :answer1
      t.string      :answer2
      t.string      :answer3
      
      t.integer     :result
      
      t.references  :user
      
      t.timestamps  null: false
    end
    
    add_index   :questions, :user_id
    
  end
end
