# Students and Courses
#
# Write a set of classes to model `Student`s and `Course`s.
#
# ## Instructions
# 1. Run `bundle install` in the root directory of the project.
# 2. Run the specs one at a time in this order:
#
# ```bash
# bundle exec rspec spec/student_spec.rb
# bundle exec rspec spec/course_spec.rb
# bundle exec rspec spec/extension_spec.rb
# ```
#
# When you are finished with the extras, comment in line 7 in the
# `spec/course_spec.rb` file and run all of the specs at once with `bundle
# exec rspec`. Make sure everything passes!
#

# ## Course
# * `Course#initialize` should take the course name, department, and
#   number of credits.
# * `Course#students` should return a list of the enrolled students.
# * `Course#add_student` should add a student to the class.
#   * Probably can rely upon `Student#enroll`.
#
# ## And some extras:
# * Each course should also take a set of days of the week (`:mon`,
#   `:tue`, ...), plus a time block (assume each day is broken into 8
#   consecutive time blocks). So a course could meet
#   `[:mon, :wed, :fri]` during block #1.
#     * Update your `#initialize` method to also take a time block and
#       days of the week.
# * Write a method `Course#conflicts_with?` which takes a second
#   `Course` and returns true if they conflict.
# * Update `Student#enroll` so that you raise an error if a `Student`
#   enrolls in a new course that conflicts with an existing course time.
#     * May want to write a `Student#has_conflict?` method to help.

class Course
  attr_accessor :name, :department, :credits, :days, :time_block, :students

  def initialize(name, department, credits, days, block)
    @name = name
    @department = department
    @credits = credits
    @days = days
    @time_block = block
    @students = []
  end

  def add_student(student)
    student.enroll(self)
  end

  def conflicts_with?(course)
    self.days.each do |day|
      if (course.days.include?(day)) && (course.time_block == self.time_block)
        return true
      end
    end

    return false
  end

end