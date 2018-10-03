# frozen_string_literal: true

FactoryBot.define do
    factory :user do
      trait :admin do
        email { 'alimalik11512+20@gmail.com' }
        password { 'aliabbasmalik' }
        role { 2 }
        confirmed_at { Time.now }
      end

      trait :moderator do
        email { 'alimalik11512+4@gmail.com' }
        password { '123456' }
        role { 1 }
        confirmed_at { Time.now }
      end

      trait :user do
        email { 'alimalik11512+4@gmail.com' }
        password { '123456' }
        role { 0 }
        confirmed_at { Time.now }
      end
    end
  end
  