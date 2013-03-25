module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "CourseVerse"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def number_to_season(n)
  	case n
  	  when 1
  	  	return 'Spring'
  	  when 2
  	  	return 'Summer'
  	  when 3
  	  	return 'Fall'
  	  when 4
  	  	return 'Winter'
  	  else
  	  	return 'Error'
  	end
  end

  def verse_topic(n)
    case n
      when 1
        return "What did you learn?"
      when 2
        return "How did you study?"
      when 3
        return "How is the work load?"
      when 4
        return "How was the teaching experience?"
      else
        return 'Error'
    end
  end

end
