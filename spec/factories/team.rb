FactoryGirl.define do
  factory :team do
    sequence(:location) {|n| "Atlanta#{n}" }
    sequence(:name) {|n| "Falcons#{n}" }
    abbreviation "ATL"
    division "NFC South"
  end
end
