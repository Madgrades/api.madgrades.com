require 'test_helper'

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule = schedules(:one)
  end

  test "should get index" do
    get schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_schedule_url
    assert_response :success
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post schedules_url, params: { schedule: { end_time: @schedule.end_time, fri: @schedule.fri, mon: @schedule.mon, sat: @schedule.sat, start_time: @schedule.start_time, sun: @schedule.sun, thurs: @schedule.thurs, tues: @schedule.tues, wed: @schedule.wed } }
    end

    assert_redirected_to schedule_url(Schedule.last)
  end

  test "should show schedule" do
    get schedule_url(@schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_schedule_url(@schedule)
    assert_response :success
  end

  test "should update schedule" do
    patch schedule_url(@schedule), params: { schedule: { end_time: @schedule.end_time, fri: @schedule.fri, mon: @schedule.mon, sat: @schedule.sat, start_time: @schedule.start_time, sun: @schedule.sun, thurs: @schedule.thurs, tues: @schedule.tues, wed: @schedule.wed } }
    assert_redirected_to schedule_url(@schedule)
  end

  test "should destroy schedule" do
    assert_difference('Schedule.count', -1) do
      delete schedule_url(@schedule)
    end

    assert_redirected_to schedules_url
  end
end
