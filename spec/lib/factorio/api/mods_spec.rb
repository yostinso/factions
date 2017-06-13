require "rails_helper"

RSpec.describe Factorio::API::Auth do
  let(:username) { ENV["FAC_USER"] }
  let(:password) { ENV["FAC_PASS"] }
  let(:bad_mod_name) { "yostinso" }
  let(:mod_name) { "PoweredFloor" }
  let(:powered_floor) {
    have_attributes(
      name: mod_name,
      title: be_present,
      summary: be_present,
      description: be_present,
      author: be_present,
      mod_releases: include(
        have_attributes(
          version: Gem::Version.new("0.0.1"),
          min_game_version: Gem::Version.new("0.13"),
          file_name: "PoweredFloor_0.0.1.zip",
          download_url: match(/\/api\/.*PoweredFloor_0\.0\.1\.zip$/)
        )
      )
    )
  }
  context "when not authenticated" do
    let(:mods) { Factorio::API::Mods.new }
    describe "#get_by_name" do
      it "should fail to find a nonexistent mod", api: true do
        expect { mods.get_by_name(bad_mod_name) }.to raise_error(Factorio::API::Error, "Not found.")
      end
      it "should find a mod", api: true do
        m = mods.get_by_name(mod_name)
        expect(m).to powered_floor
      end
    end

    describe "#search" do
      let(:search_term) { "Powered" }
      it "should find some mods", api: true do
        results = mods.search(search_term, page_size: 10)
        expect(results).to include(
          have_attributes(name: mod_name)
        )
      end
    end

    describe "#download" do
      let (:mod) { FactoryGirl.create(:mod, :powered_floor) }
      it "should read a mod into an IO buffer" do
        expect { mods.download(mod, StringIO.new) }.to raise_error(Factorio::API::Error, "Auth required!")
      end
    end

  end

  context "when authenticated" do
    let(:auth) { FactionsTest.get_test_auth }
    let(:mods) { Factorio::API::Mods.new(auth) }
    describe "#download", authed: true, api: true do
      let (:mod) { FactoryGirl.create(:mod, :powered_floor) }
      it "should download the file into an IO" do
        puts auth.inspect
        puts auth.logged_in?
        sio = StringIO.new
        mods.download(mod, sio)
        expect(sio.size).to be > 20000
      end
    end
  end
end
