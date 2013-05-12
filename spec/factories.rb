FactoryGirl.define do
  factory :user do
    name      "Jake Klassen"
    email     "klassenja@hotmail.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end