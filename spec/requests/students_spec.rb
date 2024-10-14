
require 'rails_helper'
 
#request specs for the Students resource focusing on HTTP requests
RSpec.describe "Students", type: :request do
# puts "Line 6, Students: "+Student.count.to_s
  # GET /students (index)
  describe "GET /students" do
    context "when students exist" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 1: Returns a successful response and displays the search form
      it "returns a successful response and displays the search form" do
        get students_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Search') # Ensure search form is rendered
      end

      # Test 2: Ensure it does NOT display students without a search
      it "does not display students until a search is performed" do
        get students_path
        expect(response.body).to_not include("Aaron")
      end
    end

    # Test 3: Handle missing records or no search criteria provided
    context "when no students exist or no search is performed" do
      it "displays a message prompting to search" do
        get students_path
        # Updated to reflect Index implementation.
        expect(response.body).to include("Please Enter Search Filters.") 
      end
    end
  end
# puts "Line 35, Students: "+Student.count.to_s
  # Search functionality
  describe "GET /students (search functionality)" do
    let!(:student1) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }
    let!(:student2) { Student.create!(first_name: "Jackie", last_name: "Joyner", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning", graduation_date: "2026-05-15") }

    # Test 4: Search by major
    it "returns students matching the major" do
      get students_path, params: { search: { major: "Computer Science BS" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 5: Search by expected graduation date (before)
    it "returns students graduating before the given date" do

      # Updated to reflect Index implementation.
      get students_path, params: { search: { graduation_date: "2026-01-01", graduation_relation: "Before" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 6: Search by expected graduation date (after)
    it "returns students graduating After the given date" do

      # Updated to reflect Index implementation.
      get students_path, params: { search: { graduation_date: "2026-01-01", graduation_relation: "After" } }
      expect(response.body).to include("Jackie")
      expect(response.body).to_not include("Aaron")
    end

  end
# puts "Line 67, Students: "+Student.count.to_s
  # POST /students (create)
  describe "POST /students" do
    context "with valid parameters" do
      # Test 7: Create a new student and ensure it redirects
      it "creates a new student and redirects" do
        expect {
          post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:found)  # Expect redirect after creation
        follow_redirect!
        expect(response.body).to include("Aaron")  # Student's details in the response
      end

      # Test 8 (Student will complete this part)
      # Ensure that it returns a 201 status or check for creation success
      # Note: I cannot get this code to have anything other than 200 be passed into it. I am unsure where the 
      it "return status 200 or creation success" do
        expect {
          post students_path, params: { student: { first_name: "Jackie", last_name: "Joyner", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning", graduation_date: "2026-05-15" } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(302)  # Expect redirect after creation.
        follow_redirect!
        expect(response).to have_http_status(200)  # Expect Creation Success
        expect(response.body).to include("Jackie")  # Student's details in the response
      end
    end

    context "with invalid parameters" do
      # Test 9 (Student will complete this part)
      # Ensure it does not create a student and returns a 422 status
      it "return status 422" do
        expect {
          post students_path, params: { student: { first_name: "Jackie", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning", graduation_date: "2026-05-15" } }
        }.to change(Student, :count).by(0)

        expect(response).to have_http_status(422)  # Expect redirect after creation. How to assign a response code to the controller?
      end
    end
  end
# puts "Line 109, Students: "+Student.count.to_s
  # GET /students/:id (show)
  describe "GET /students/:id" do
    context "when the student exists" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 10 (Student will complete this part)
      # Ensure it returns a successful response (200 OK)
      it "accesible page that is not the search page" do
        
        expect {
          get students_path+"/1"
        }.to change(Student, :count).by(0)

        expect(response).to have_http_status(200)
        expect(response.body).to include("Aaron")
        expect(response.body).to_not include("Search")
      end
      # Test 11 (Student will complete this part)
      # Ensure it includes the student's details in the response body
      it "student page has student details" do
        
        expect {
          get students_path+"/1"
        }.to change(Student, :count).by(0)

        expect(response).to have_http_status(200)
        expect(response.body).to include("Aaron")
        expect(response.body).to include("Gordon")
        expect(response.body).to include("gordon@msudenver.edu")
        expect(response.body).to include("Computer Science BS")
        expect(response.body).to include("2025-05-15")
      end
    end

    # Test 12: Handle missing records
    it "student index out of range" do
      expect {
        get students_path+"/9999"
      }.to change(Student, :count).by(0)

      expect(response).to have_http_status(404)
      expect(response.body).to include("Invalid Student Index.")
      # HELP
    end

  end
# puts "Line 137, Students: "+Student.count.to_s
  # DELETE /students/:id (destroy)
  describe "DELETE /students/:id" do
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

    # Test 13: Deletes the student and redirects
    it "delete student that exists" do
      delete :student
      expect(response).to have_http_status(302)
      expect(response.body).to include("Search")
      # HELP
    end

    # Test 14: Returns a 404 when trying to delete a non-existent student
    it "returns a 404 status when trying to delete a non-existent student" do
      delete "/students/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end