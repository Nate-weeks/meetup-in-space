require "factory_girl"

FactoryGirl.define do
  factory :meetup do
    name "saturn meetup"
    location "saturn"
    description "a meetup on saturn"
    creator_id "Nate"
  end
end
