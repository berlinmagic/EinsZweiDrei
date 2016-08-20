FactoryGirl.define do

  factory :feedback do
    subject "contact"
    content "Hello World"
    user nil
    name "ingo"
    email "ingo@example.com"
    current_controller ""
    current_action ""
    current_params ""
  end

end
