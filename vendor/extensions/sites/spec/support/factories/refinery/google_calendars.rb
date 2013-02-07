
FactoryGirl.define do
  factory :google_calendar, :class => Refinery::Sites::GoogleCalendar do
    sequence(:account) { |n| "refinery#{n}" }
  end
end

