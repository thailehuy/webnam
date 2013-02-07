
FactoryGirl.define do
  factory :product, :class => Refinery::Sites::Product do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

