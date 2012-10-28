FactoryGirl.define do
  factory :traveller do
    firstname "Dave"
    lastname  "Sewell"
    email     "snocorp@gmail.com"
    password  "passwd"
    password_confirmation "passwd"
  end
  
  factory :admin, class: Traveller do
    firstname "Admin"
    lastname  "User"
    email     "admin@jurny.com"
    password  "password123"
    password_confirmation "password123"
    admin     true
  end
end
