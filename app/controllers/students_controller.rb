class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index

    # Logging
    # Rails.logger.info "Params: #{params.inspect}"

    @search_params = params[:search] || {}
    @students = Student.all

    # I find this syntax to be unclear. I know that it is referecing data coming
    # from the request and referencing calls to the Model to access things from
    # the database, but which is which and the underlying logic I need to
    # investigate.

    # Logging
    Rails.logger.info "Params: #{@search_params.inspect}"

    if @search_params[:major].present?
      @students = @students.where(major: @search_params[:major])
    end

    # If the user selected to search by grad date...
'''    if @search_params[:graduation_relation].present?

      # If the selection is Before
      if @search_params[:graduation_relation].equal("Before")
        puts "Test"
      end
    end'''
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :graduation_date, :profile_picture)
    end
end
