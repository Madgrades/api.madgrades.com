class Schedule < ApplicationRecord
  self.primary_key = :uuid

  def to_param
    uuid
  end

  def start_time_clock
    if start_time > 0
      Time.at(start_time * 60).utc.strftime("%H:%M")
    else
      nil
    end
  end

  def end_time_clock
    if end_time > 0
      Time.at(end_time * 60).utc.strftime("%H:%M")
    else
      nil
    end
  end

  def days
    result = ''
    result = 'M' if mon
    result += 'T' if tues
    result += 'W' if wed
    result += 'R' if thurs
    result += 'F' if fri
    result += 'S' if sat
    result += 'N' if sun
    if result == ''
      return nil
    end
    result
  end
end
