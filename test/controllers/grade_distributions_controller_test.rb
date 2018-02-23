require 'test_helper'

class GradeDistributionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grade_distribution = grade_distributions(:one)
  end

  test "should get index" do
    get grade_distributions_url
    assert_response :success
  end

  test "should get new" do
    get new_grade_distribution_url
    assert_response :success
  end

  test "should create grade_distribution" do
    assert_difference('GradeDistribution.count') do
      post grade_distributions_url, params: { grade_distribution: { a_count: @grade_distribution.a_count, ab_count: @grade_distribution.ab_count, b_count: @grade_distribution.b_count, bc_count: @grade_distribution.bc_count, c_count: @grade_distribution.c_count, course_uuid: @grade_distribution.course_uuid, cr_count: @grade_distribution.cr_count, d_count: @grade_distribution.d_count, f_count: @grade_distribution.f_count, i_count: @grade_distribution.i_count, n_count: @grade_distribution.n_count, nr_count: @grade_distribution.nr_count, nw_count: @grade_distribution.nw_count, other_count: @grade_distribution.other_count, p_count: @grade_distribution.p_count, s_count: @grade_distribution.s_count, section_number: @grade_distribution.section_number, u_count: @grade_distribution.u_count } }
    end

    assert_redirected_to grade_distribution_url(GradeDistribution.last)
  end

  test "should show grade_distribution" do
    get grade_distribution_url(@grade_distribution)
    assert_response :success
  end

  test "should get edit" do
    get edit_grade_distribution_url(@grade_distribution)
    assert_response :success
  end

  test "should update grade_distribution" do
    patch grade_distribution_url(@grade_distribution), params: { grade_distribution: { a_count: @grade_distribution.a_count, ab_count: @grade_distribution.ab_count, b_count: @grade_distribution.b_count, bc_count: @grade_distribution.bc_count, c_count: @grade_distribution.c_count, course_uuid: @grade_distribution.course_uuid, cr_count: @grade_distribution.cr_count, d_count: @grade_distribution.d_count, f_count: @grade_distribution.f_count, i_count: @grade_distribution.i_count, n_count: @grade_distribution.n_count, nr_count: @grade_distribution.nr_count, nw_count: @grade_distribution.nw_count, other_count: @grade_distribution.other_count, p_count: @grade_distribution.p_count, s_count: @grade_distribution.s_count, section_number: @grade_distribution.section_number, u_count: @grade_distribution.u_count } }
    assert_redirected_to grade_distribution_url(@grade_distribution)
  end

  test "should destroy grade_distribution" do
    assert_difference('GradeDistribution.count', -1) do
      delete grade_distribution_url(@grade_distribution)
    end

    assert_redirected_to grade_distributions_url
  end
end
