require 'rails_helper'

RSpec.describe Mod, type: :model do
  let(:mod) { FactoryGirl.create(:mod) }

  describe "#supports_version?" do
    let(:supported_version) { FactoryGirl.create(:mod_release, mod: mod, min_game_version: "0.13") }
    let(:unsupported_version) { FactoryGirl.create(:mod_release, mod: mod, min_game_version: "0.12") }
    let(:game_version) { "0.13" }

    it "should return true when supported" do
      expect(supported_version.mod.supports_version?(game_version)).to be_truthy
    end

    it "should return false when unsupported" do
      expect(unsupported_version.mod.supports_version?(game_version)).to be_falsy
    end
  end

  describe "#mod_releases#current_release" do
    let!(:v1) { FactoryGirl.create(:mod_release, mod: mod, version: "0.13") }
    let!(:v2) { FactoryGirl.create(:mod_release, mod: mod, version: "0.14") }

    it "should return the single newest record" do
      expect(mod.mod_releases.current_release).to eq(v2)
    end

    it "should return nil if there are no matching records" do
      expect(mod.mod_releases.supporting_version("0.1").current_release).to be_nil
    end
  end

end
