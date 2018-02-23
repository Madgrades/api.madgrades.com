class CourseOffering < ApplicationRecord
  self.primary_key = :uuid

  default_scope { order(term_code: :asc) }

  def term_name
    # get season
    season_id = term_code % 10
    term_year = term_code / 10

    offset = term_year - 101

    # account for fall season being 1 greater than other seasons
    offset -= 1 if season_id == 2

    calendar_year = 2001 + offset
    if season_id == 4
      return "Spring #{calendar_year}"
    elsif season_id == 6
      return "Summer #{calendar_year}"
    elsif season_id == 2
      return "Fall #{calendar_year}"
    end
  end

  def course
    Course.find(course_uuid)
  end

  def sections(id=nil)
    Section.where(course_offering_uuid: uuid)
  end

  def to_param
    uuid
  end
end
