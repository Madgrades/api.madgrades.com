class GradeDistribution < ApplicationRecord
  def course_offering
    CourseOffering.find(course_offering_uuid)
  end

  def course
    course_offering.course
  end

  def sections
    course_offering.sections.where(number: section_number)
  end

  def term_code
    course_offering.term_code
  end

  def term_name
    course_offering.term_name
  end

  def total
    %w(a_count ab_count b_count bc_count c_count d_count f_count).map{|col| self[col]}.sum
  end

  def avg
    total_counts = total
    if total_counts == 0
      return 0
    end

    weighted = 4 * a_count +
        3.5 * ab_count +
        3 * b_count +
        2.5 * bc_count +
        2 * c_count +
        1 * d_count +
        0 * f_count
    (4 * weighted / (4 * total_counts)).round(2)
  end

  def counts
    result = {}
    %w(a_count ab_count b_count bc_count c_count d_count f_count).each do |col|
      result[col.partition('_').first.upcase] = self[col]
    end
    result
  end

  def percents(scale)
    total = total_count
    result = counts
    result.each{|col, count| result[col] = scale * (count.to_d / total.to_d)}
  end

  def course
    course_offering.course
  end
end
