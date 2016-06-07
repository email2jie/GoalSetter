FactoryGirl.define do
  factory :goal do
    title { Faker::Name.name }
    description { Faker::StarWars.quote }
    completion { Faker::Date.forward(3000) }
    user_id { 1 }
    kind { %w(public private).sample }


      factory :private_goal do
        user_id 2
        kind 'private'
      end

      factory :public_goal do
        user_id 2
        kind 'public'
      end

      factory :my_private_goal do
        user_id 1
        kind 'private'
      end

      factory :my_public_goal do
        user_id 1
        kind 'public'
      end





  end

end
