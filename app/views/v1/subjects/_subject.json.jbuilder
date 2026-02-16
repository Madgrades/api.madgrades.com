json.extract! subject, :code, :name, :abbreviation
json.courses_url v1_courses_url(subject: subject.code)