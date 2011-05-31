module TalksHelper
  def casual_day_description(time)
    time_diff = time - Time.now
    if time_diff < 0 
      case time_diff.abs
        when 0..1.day then 'Yesterday'
        else "#{time.strftime("%A, %d %B, %Y")}"
      end
    else
      case time_diff
        when 0...1.day then 'Today'
        when 1.day...2.days then 'Tomorrow'
        when 2.days...7.days then "This #{time.strftime("%A")}"
        else "#{time.strftime("%A, %d %B, %Y")}"
      end
    end
  end
end
