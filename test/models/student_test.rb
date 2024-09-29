# test/model/student_test.rb
require "test_helper"

class StudentsTest < ActiveSupport::TestCase

  # Test 0: Nominal Student
  test "student_has_first_name" do
    assert Student.create!(first_name: "Tyler", last_name: "Andreasen", school_email: "tand@msudenver.edu", major: "Debugging", graduation_date: "2024/09/23")
  end

=begin
  ##
  # I would like to implement tests that verify that a stink is made by rails
  # if for example the first_name field is blank, but I cannot for the
  # life of me figure out what the syntax needs to be to get the test to be
  # valid and not throw an error. Also, I do not understand why the controller
  # tests are running when I am specifying the model.

  # test "the truth" do
  #   assert true
  # end
=end

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

  # Test 3: Ensure Spadetail has expected email.
  test "spadetails_email_matches_literal" do
    assert_equal "cspadeta@msudenver.edu", students(:spadetail).school_email
  end


  # Test 4: Find by Name that doesn't exist
  test "student_record_of_name_doesn't_exist" do
    assert_raise(StandardError) { students(:sotha) }
  end

  # Test 5: Successfully Update Student Name
  test "assign_student_new_name" do
    students(:spadetail).first_name = "Champion"
    assert_equal "Champion", students(:spadetail).first_name
  end

  # Test 6: Attempt to Assign a duplicate email.
  # This currently does not function as intended, as the duplicate email still assigns.
  test "school_email_updated_to_existing_value" do
    assert students(:spadetail).school_email = "inerevar@msudenver.edu"
  end
=begin
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