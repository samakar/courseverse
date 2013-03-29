module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "CourseVerse"
    if page_title.empty?
      "#{base_title} | College Course Reviews"
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
        return "What did you do for final exam/report?"
      when 3
        return "How is the course load?"
      when 4
        return "How was the teaching experience?"
      else
        return 'Error'
    end
  end

end
