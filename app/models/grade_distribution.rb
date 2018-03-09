class GradeDistribution < ApplicationRecord
  def self.zero
    res = GradeDistribution.new
    res.attributes.each_pair do |name, _|
      if name.ends_with?('_count')
        res[name] = 0
      end
    end
    res
  end

  def self.grade_fields(include_misc=false)
    fields = %w(a_count ab_count b_count bc_count c_count d_count f_count)
    if include_misc
      fields = fields + %w(s_count u_count cr_count n_count p_count i_count nw_count nr_count other_count)
    end
    fields
  end

  def +(other)
    res = GradeDistribution.new
    attributes.each_pair do |name, value|
      if value != nil && name.ends_with?('_count')
        res[name] = value + other[name]
      end
    end
    res
  end

  def course_offering
    CourseOffering.find(course_offering_uuid)
  end

  def real?
    !course_offering_uuid.nil?
  end

  def sections
    Section.where(:course_offering_uuid => course_offering_uuid, :number => section_number)
  end

  def term_code
    course_offering.term_code
  end

  def term_name
    course_offering.term_name
  end

  def gpa_total
    %w(a_count ab_count b_count bc_count c_count d_count f_count).map{|col| self[col] || 0}.sum
  end

  def total
    sum = 0
    attributes.each_pair do |name, value|
      if name.ends_with?('_count')
        sum += value
      end
    end
    sum
  end

  def gpa
    weighted = 4 * a_count +
        3.5 * ab_count +
        3 * b_count +
        2.5 * bc_count +
        2 * c_count +
        1 * d_count +
        0 * f_count
    (4 * weighted / (4 * gpa_total)).round(3)
  end
end
