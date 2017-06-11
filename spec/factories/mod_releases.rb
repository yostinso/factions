FactoryGirl.define do
  factory :mod_release do
    association :mod
    version "0.0"
    game_version "0.0"
    min_game_version "0.0"
    download_url "https://www.aradine.com/mods/MyTestMod.zip"
    file_name "MyTestMod.zip"
  end
end
