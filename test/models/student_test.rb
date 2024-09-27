# test/model/student_test.rb
require "test_helper"

class StudentTest < ActiveSupport::TestCase

  test "student_has_first_name" do
    assert Student.create!(first_name: "Tyler", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
  end

  test "student_has_no_first_name" do
    assert_raises(RecordInvalid)
      Student.create!(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
  end

end