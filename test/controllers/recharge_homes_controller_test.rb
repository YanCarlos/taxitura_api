require 'test_helper'

class RechargeHomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recharge_homes_index_url
    assert_response :success
  end

end
