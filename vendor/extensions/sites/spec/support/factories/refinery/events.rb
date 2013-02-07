
FactoryGirl.define do
  factory :event, :class => Refinery::Sites::Event do
    sequence(:event_title) { |n| "refinery#{n}" }
  end
end

