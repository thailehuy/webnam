
FactoryGirl.define do
  factory :design, :class => Refinery::Sites::Design do
    sequence(:scss_model) { |n| "refinery#{n}" }
  end
end

