require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /students" do

    # Test 0 Ensure Test Pipeline functions
    it "works! (now write some real specs)" do
      get students_path
      expect(response).to have_http_status(200)
    end

    context "when students exist" do 
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") } 
      
      # Test 1: Returns a successful response and displays the search form 
      it "returns a successful response and displays the search form" do 
        get students_path 
        expect(response).to have_http_status(:ok) 
        expect(response).to include('Select Major') # Ensure search form is rendered 
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
        expect(response.body).to include("Please enter search criteria to find students") 
      end
    end
  end


  describe "GET [students (search functionality)" do 
    let!(:studentl) { Student.create!(first_name: "Aaron", last _ name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") } 
    let!(:student2) { Student.create!(first_name: "Jackie", last _ name: "Joyner", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning", graduation_date: "2026-05-15") } 
    # Test 4: Search by major 
    it "returns students matching the major" do 
      get students_path, params: { search: { major: "Computer Science BS" } } 
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie") 
    end
  end


    # POST /students (create) 
  describe "POST /students" do 
    context "with valid parameters" do 
      # Test 4: Create a new student and ensure it redirects 
      it "'creates a new student and redirects" do 
      expect { 
      post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } } 
      }.to change(Student, :count).by(1) 

      expect(response).to have_http_status(:found) # Expect redirect after creation 
      follow redirect! 
      expect(response).to include("Aaron") # Student's details in the response
      end
    end
  end


  # DELETE [students/:id (destroy) 
  describe "DELETE [students/:id" do 
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") } 
    # Test 14: Returns a 404 when trying to delete a non-existent student 
    it "returns a 404 status when trying to delete a non-existent student" do 
      delete "/students/9999" 
      expect(response).to have_http_status(:not_found)
    end 
  end
end

