# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    edition_year "MyString"
    start_date "2013-12-23"
    end_date "2013-12-23"
    location "MyString"
  end
end
