require 'rails_helper'

RSpec.describe ModRelease, type: :model do
  describe "#newest" do
    let(:mod) { FactoryGirl.build(:mod) }
    let!(:v1) { r = FactoryGirl.create(:mod_release, mod: mod, version: "0.13"); mod.mod_releases << r; r }
    let!(:v2) { r = FactoryGirl.create(:mod_release, mod: mod, version: "0.14"); mod.mod_releases << r; r }
    let!(:v3) { r = FactoryGirl.create(:mod_release, mod: mod, version: "0.12"); mod.mod_releases << r; r }
    it "should return the newest version" do
      expect(ModRelease.newest).to contain_exactly(v2)
    end
  end
end
