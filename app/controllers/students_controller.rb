class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index

    # Logging
    # Rails.logger.info "Params: #{params.inspect}"

    @search_params = params[:search] || {}
    @students = Student.all
    @no_search_params = false

    # TODO TEST THIS CODE
    # Thank you to Evan Cline for this code
    if @search_params.values.all?(&:blank?)
      # puts "Cana 699 No Search Data"
      @students = nil
      @no_search_params = true
    end

    if @search_params[:major].present?
      # puts "Cana 600  - Search by Major"
      @students = @students.where(major: @search_params[:major])
    end

    # If the user entered a date ...
    if @search_params[:graduation_date].present?

      # puts "Cana 601 - Search by Graduation Date"

      # If the user selected to search by grad date...
      if @search_params[:graduation_relation].present?
 

        @temp = @search_params[:graduation_date].to_s
        # This feels like it could fall apart easily, but I am unsure how else to implement
        @yr = @temp[0..3]
        @mt = @temp[5..6]
        @dy = @temp[8..9]

        # ... If the selection is Before
        if @search_params[:graduation_relation] == "Before"
          # puts "Cana 602 - Search by Graduation Date: Before: "+@temp
          @students = @students.where(:graduation_date => Time.new(1970,1,1)..Time.new(@yr,@mt,@dy))
        # ... If the selection is After
        elsif @search_params[:graduation_relation] == "After"
          # puts "Cana 603 - Search by Graduation Date: After"
          @students = @students.where(:graduation_date => Time.new(@yr,@mt,@dy)..Time.new(9999, 12, 31))
        end
      end
    end

    if @search_params[:search_all].present?
      if @search_params[:search_all] == "View All"
        @students = Student.all
      end
    end
  
    
    # IMPORTANT:: This is always the last search filter!!
    # if @search_params[:student_count].present?
    #   @students.limit(:student_count)
    # end

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
    @student_count = Student.count.to_int

    if (params[:id].to_i > @student_count) | (params[:id].to_i < 1)
      respond_to do |format|
        format.html { redirect_to students_url, status: :not_found, notice: "Could not destroy student: Invalid Index." }
        format.json { head :no_content }
      end
    else
      @student.destroy!

      respond_to do |format|
        format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student_count = Student.count.to_int

      if (params[:id].to_i > @student_count) | (params[:id].to_i < 1)
        respond_to do |format|
          format.html { redirect_to students_url, status: :not_found, notice: "Invalid Student Index." }
          format.json { head :no_content }
        end
      else
        @student = Student.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :major, :graduation_date, :profile_picture)
    end
end
