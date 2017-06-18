require 'test_helper'

class TestSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_session = test_sessions(:one)
  end

  test "should get index" do
    get test_sessions_url
    assert_response :success
  end

  test "should get new" do
    get new_test_session_url
    assert_response :success
  end

  test "should create test_session" do
    assert_difference('TestSession.count') do
      post test_sessions_url, params: { test_session: { test_date: @test_session.test_date, time: @test_session.time } }
    end

    assert_redirected_to test_session_url(TestSession.last)
  end

  test "should show test_session" do
    get test_session_url(@test_session)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_session_url(@test_session)
    assert_response :success
  end

  test "should update test_session" do
    patch test_session_url(@test_session), params: { test_session: { test_date: @test_session.test_date, time: @test_session.time } }
    assert_redirected_to test_session_url(@test_session)
  end

  test "should destroy test_session" do
    assert_difference('TestSession.count', -1) do
      delete test_session_url(@test_session)
    end

    assert_redirected_to test_sessions_url
  end
end
