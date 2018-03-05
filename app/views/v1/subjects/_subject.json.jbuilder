json.extract! subject, :code, :name, :abbreviation
json.courses_url courses_url(subject: subject.code)