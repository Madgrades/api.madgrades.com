require 'test_helper'

class TeachingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teaching = teachings(:one)
  end

  test "should get index" do
    get teachings_url
    assert_response :success
  end

  test "should get new" do
    get new_teaching_url
    assert_response :success
  end

  test "should create teaching" do
    assert_difference('Teaching.count') do
      post teachings_url, params: { teaching: { instructor_id: @teaching.instructor_id, section_uuid: @teaching.section_uuid } }
    end

    assert_redirected_to teaching_url(Teaching.last)
  end

  test "should show teaching" do
    get teaching_url(@teaching)
    assert_response :success
  end

  test "should get edit" do
    get edit_teaching_url(@teaching)
    assert_response :success
  end

  test "should update teaching" do
    patch teaching_url(@teaching), params: { teaching: { instructor_id: @teaching.instructor_id, section_uuid: @teaching.section_uuid } }
    assert_redirected_to teaching_url(@teaching)
  end

  test "should destroy teaching" do
    assert_difference('Teaching.count', -1) do
      delete teaching_url(@teaching)
    end

    assert_redirected_to teachings_url
  end
end
