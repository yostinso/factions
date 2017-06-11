require "rails_helper"

RSpec.describe Factorio::API::Auth do
  let(:username) { ENV["FAC_USER"] }
  let(:password) { ENV["FAC_PASS"] }
  let(:bad_mod_name) { "yostinso" }
  let(:mod_name) { "PoweredFloor" }
  context "when not authenticated" do
    let(:mods) { Factorio::API::Mods.new }
    describe "#get_by_name" do
      it "should fail to find a nonexistent mod" do
        skip "API calls" unless ENV["DO_API_TEST"]
        expect { mods.get_by_name(bad_mod_name) }.to raise_error(Factorio::API::Error, "Not found.")
      end
      it "should find a mod" do
        m = mods.get_by_name(mod_name)
        expect(m).to have_attributes(
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
      end
    end

  end
end
