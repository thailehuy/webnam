
FactoryGirl.define do
  factory :blog_post, :class => Refinery::Sites::BlogPost do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

