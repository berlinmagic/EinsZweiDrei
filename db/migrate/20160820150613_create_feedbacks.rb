class CreateFeedbacks < ActiveRecord::Migration
  def change

    create_table :feedbacks do |t|
      t.string      :subject
      t.text        :content

      t.references  :user
      t.string      :name
      t.string      :email

      t.string      :current_controller
      t.string      :current_action
      t.text        :current_params

      t.timestamps  null: false
    end

    add_index   :feedbacks, :user_id
    add_index   :feedbacks, :email

  end
end
