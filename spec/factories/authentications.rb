# encoding: utf-8
FactoryGirl.define do

  factory :authentication do
    email     "user@exampl.com"
    uid       "uid000xxx123456789xx99xx987"
    provider  "FishBook"
    link      "http://fishbook.exampl.com/fish/23"
    user      nil
  end

end
