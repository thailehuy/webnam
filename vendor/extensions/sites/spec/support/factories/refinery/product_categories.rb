
FactoryGirl.define do
  factory :product_category, :class => Refinery::Sites::ProductCategory do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

