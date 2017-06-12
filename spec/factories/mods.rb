FactoryGirl.define do
  factory :mod do
    name "MyTestMod"
    title "My test mod"
    summary "This is not a real mod"
    description "It really isn't a real mod"
    author "The Tester"

    trait :powered_floor do
      name "PoweredFloor"
      title "Powered floor"
      summary "Flooring that transmits power to adjacent objects"
      description "Adds tiles which provide power to whatever's sitting on top of them. Also adds a power tap to feed these tiles\r\n\r\n-  Powered Floor Tile: Powers objects on top and neighboring tiles\r\n\r\n-  Powered Floor Circuit Tile: Also transmits red & green circuit signals to neighboring tiles.  \r\n                              (Does *not* feed these to objects on top.)\r\n\r\n-  Powered Floor Tap:  A stubby electric pole that transmits power to the tiles, and circuit signals to/from the circuit tiles."
      author "Theanderblast"
      mod_releases { build_list(:mod_release, 1, :powered_floor_0_0_1) }
    end

    after :build do |mod|
      if mod.mod_releases.blank?
        mod.mod_releases << FactoryGirl.build(:mod_release, mod: mod)
      end
    end
  end
end
