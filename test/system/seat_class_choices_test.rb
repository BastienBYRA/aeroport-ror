require "application_system_test_case"

class SeatClassChoicesTest < ApplicationSystemTestCase
  setup do
    @seat_class_choice = seat_class_choices(:one)
  end

  test "visiting the index" do
    visit seat_class_choices_url
    assert_selector "h1", text: "Seat class choices"
  end

  test "should create seat class choice" do
    visit seat_class_choices_url
    click_on "New seat class choice"

    fill_in "Name", with: @seat_class_choice.name
    click_on "Create Seat class choice"

    assert_text "Seat class choice was successfully created"
    click_on "Back"
  end

  test "should update Seat class choice" do
    visit seat_class_choice_url(@seat_class_choice)
    click_on "Edit this seat class choice", match: :first

    fill_in "Name", with: @seat_class_choice.name
    click_on "Update Seat class choice"

    assert_text "Seat class choice was successfully updated"
    click_on "Back"
  end

  test "should destroy Seat class choice" do
    visit seat_class_choice_url(@seat_class_choice)
    click_on "Destroy this seat class choice", match: :first

    assert_text "Seat class choice was successfully destroyed"
  end
end
