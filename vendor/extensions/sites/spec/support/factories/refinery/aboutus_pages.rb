
FactoryGirl.define do
  factory :aboutus_page, :class => Refinery::Sites::AboutusPage do
    sequence(:category) { |n| "refinery#{n}" }
  end
end

