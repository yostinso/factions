FactoryGirl.define do
  factory :mod do
    name "MyTestMod"
    title "My test mod"
    summary "This is not a real mod"
    description "It really isn't a real mod"
    author "The Tester"

    after :build do |mod|
      if mod.mod_releases.blank?
        mod.mod_releases << FactoryGirl.build(:mod_release, mod: mod)
      end
    end
  end
end
