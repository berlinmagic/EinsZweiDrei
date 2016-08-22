class CreateSettings < ActiveRecord::Migration
  def change
    
    
    create_table :settings do |t|
      
      t.decimal     :blink_time,    default: 10.0           # selectTime          => 1000 * x
      t.decimal     :stop_time,     default: 3.0            # showTime            => 1000 * x
      t.integer     :interval_time, default: 120            # intervalTime        => x
      t.integer     :speed_step,    default: 20             # intervalStep        => x
      t.integer     :step_time,     default: 1000           # intervalStepEvery   => x
      t.string      :step_type,     default: "none"         # none | faster | slower
      t.string      :blink_type,    default: "highlight"    # highlight | change
      
      t.references  :user
      
      t.timestamps  null: false
    end
    
    add_index   :settings,  :user_id
    
    
  end
end
