FactoryGirl.define do

  factory :subscription do
    email "ingo@example.com"
    newsletter false
    dev_news false
    user nil
  end

end
