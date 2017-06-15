require 'test_helper'

class InputVariableValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @input_variable_value = input_variable_values(:one)
  end

  test "should get index" do
    get input_variable_values_url
    assert_response :success
  end

  test "should get new" do
    get new_input_variable_value_url
    assert_response :success
  end

  test "should create input_variable_value" do
    assert_difference('InputVariableValue.count') do
      post input_variable_values_url, params: { input_variable_value: { value: @input_variable_value.value, variable_id: @input_variable_value.variable_id } }
    end

    assert_redirected_to input_variable_value_url(InputVariableValue.last)
  end

  test "should show input_variable_value" do
    get input_variable_value_url(@input_variable_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_input_variable_value_url(@input_variable_value)
    assert_response :success
  end

  test "should update input_variable_value" do
    patch input_variable_value_url(@input_variable_value), params: { input_variable_value: { value: @input_variable_value.value, variable_id: @input_variable_value.variable_id } }
    assert_redirected_to input_variable_value_url(@input_variable_value)
  end

  test "should destroy input_variable_value" do
    assert_difference('InputVariableValue.count', -1) do
      delete input_variable_value_url(@input_variable_value)
    end

    assert_redirected_to input_variable_values_url
  end
end
