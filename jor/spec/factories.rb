FactoryGirl.define do
  factory :traveller do
    firstname "Dave"
    lastname  "Sewell"
    email     "snocorp@gmail.com"
    password  "passwd"
    password_confirmation "passwd"
  end
end
