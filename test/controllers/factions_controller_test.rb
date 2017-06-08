require 'test_helper'

class FactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get factions_index_url
    assert_response :success
  end

end
