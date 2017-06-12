FactoryGirl.define do
  factory :mod_release do
    association :mod
    version "0.0"
    game_version "0.0"
    min_game_version "0.0"
    download_url "https://www.aradine.com/mods/MyTestMod.zip"
    file_name "MyTestMod.zip"

    trait :powered_floor_0_0_1 do
      version "0.0.1"
      game_version nil
      min_game_version "0.13"
      download_url "/api/downloads/data/mods/1752/PoweredFloor_0.0.1.zip"
      file_name "PoweredFloor_0.0.1.zip"
    end
  end
end
