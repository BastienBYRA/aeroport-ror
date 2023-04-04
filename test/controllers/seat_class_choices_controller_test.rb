require "test_helper"

class SeatClassChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seat_class_choice = seat_class_choices(:one)
  end

  test "should get index" do
    get seat_class_choices_url
    assert_response :success
  end

  test "should get new" do
    get new_seat_class_choice_url
    assert_response :success
  end

  test "should create seat_class_choice" do
    assert_difference("SeatClassChoice.count") do
      post seat_class_choices_url, params: { seat_class_choice: { name: @seat_class_choice.name } }
    end

    assert_redirected_to seat_class_choice_url(SeatClassChoice.last)
  end

  test "should show seat_class_choice" do
    get seat_class_choice_url(@seat_class_choice)
    assert_response :success
  end

  test "should get edit" do
    get edit_seat_class_choice_url(@seat_class_choice)
    assert_response :success
  end

  test "should update seat_class_choice" do
    patch seat_class_choice_url(@seat_class_choice), params: { seat_class_choice: { name: @seat_class_choice.name } }
    assert_redirected_to seat_class_choice_url(@seat_class_choice)
  end

  test "should destroy seat_class_choice" do
    assert_difference("SeatClassChoice.count", -1) do
      delete seat_class_choice_url(@seat_class_choice)
    end

    assert_redirected_to seat_class_choices_url
  end
end
