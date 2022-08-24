require 'test_helper'

class SailingsControllerTest < ActionDispatch::IntegrationTest
  test "#cheapest_direct" do
    get cheapest_direct_api_sailings_path(origin_port: 'CNSHA', destination_port: 'NLRTM')
    assert_response :success
  end

  test "#cheapest_indirect" do
    get cheapest_indirect_api_sailings_path(origin_port: 'CNSHA', destination_port: 'NLRTM')
    assert_response :success
  end
end
