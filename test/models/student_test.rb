# test/model/student_test.rb
require "test_helper"

class StudentsTest < ActiveSupport::TestCase

  # Test 0: Nominal Student
  test "student_has_first_name" do
    assert Student.create!(first_name: "Tyler", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
  end

  ##
  # I would like to implement tests that verify that a stink is made by rails
  # if for example the first_name field is blank, but I cannot for the
  # life of me figure out what the syntax needs to be to get the test to be
  # valid and not throw an error. Also, I do not understand why the controller
  # tests are running when I am specifying the model.

  # test "the truth" do
  #   assert true
  # end

  # Test 1: No Data Student
  test "student_has_no_data" do
    student0 = Student.new
    assert_not student0.save
  end

  # Test 2: No First Name Student
  test "student_has_no_name" do
    student0 = Student.new(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
    assert_not student0.save
  end

  # Test 3: Clean Read of Student
  test "read_valid_student" do
    assert(:one, "Indoril exists!")
  end

=begin
  # Test 4: No First Name Student
  test "student_has_no_name" do
    student0 = Student.new(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
    assert_not student0.save
  end

  # Test 5: No First Name Student
  test "student_has_no_name" do
    student0 = Student.new(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
    assert_not student0.save
  end

  # Test 6: No First Name Student
  test "student_has_no_name" do
    student0 = Student.new(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
    assert_not student0.save
  end
  
  # Test 7: No First Name Student
  test "student_has_no_name" do
    student0 = Student.new(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
    assert_not student0.save
  end

  # Test 8: No First Name Student
  test "student_has_no_name" do
    student0 = Student.new(first_name: "", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
    assert_not student0.save
  end
=end

end