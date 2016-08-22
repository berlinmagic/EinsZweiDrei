FactoryGirl.define do
  factory :setting do
    blink_time "9.99"
    stop_time "9.99"
    interval_time 1
    speed_step 1
    step_time 1
    step_type "MyString"
    user nil
  end
end
