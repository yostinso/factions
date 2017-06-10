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
        expect { mods.get_by_name(bad_mod_name) }.to raise_error(Factorio::API::Error, "Not found.")
      end
      it "should find a mod" do
        expect(mods.get_by_name(mod_name)).to include(name: "PoweredFloor")
      end
    end
  end
end
