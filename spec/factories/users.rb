# encoding: utf-8
FactoryGirl.define do

  factory :user do
    
    first_name  { FFaker::NameDE.first_name }
    last_name   { FFaker::NameDE.last_name }
    
    gender      { FFaker::Gender.maybe }
    
    email       { FFaker::Internet.safe_email }
    password    "password"
    
  end

end
