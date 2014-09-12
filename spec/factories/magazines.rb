# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :magazine do
    name "MyString"
    content "MyText"
    url "MyString"
    published_at "2014-09-12 10:37:24"
    guid "MyString"
    tags "MyString"
  end
end
