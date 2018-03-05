json.extract! course_trend, :first_term, :last_term
json.extract! course_trend, :first_count, :last_count
json.first_gpa course_trend.first_gpa.to_f
json.last_gpa course_trend.last_gpa.to_f
json.growth_trend_score course_trend.growth_trend_score
json.gpa_trend_score course_trend.gpa_trend_score