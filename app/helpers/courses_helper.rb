module CoursesHelper
  def setup_course(course)
    s = course.schedules.build
    s.year = 2012
    course
  end
end