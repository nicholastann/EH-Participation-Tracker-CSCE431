# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    if(params[:set] == "1") then
      respond_to do |format|
        format.html
        format.csv { send_data @students.to_csv }
      end
    end
    if(params[:set] == "2") then
      respond_to do |format|
        format.html
        format.csv { send_data @students.to_csv2 }
      end
    end
  end

  def add_event
    cur_user = User.find params[:user]
    cur_event = Event.find params[:event]

    current_student = cur_user.student
    current_student.event << cur_event
    
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully attended.' }
      format.json { head :no_content }
    end
  end

  def remove_event
    cur_user = User.find params[:user]
    cur_event = Event.find params[:event]

    current_student = cur_user.student
    current_student.event.delete(cur_event)

    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully removed.' }
      format.json { head :no_content }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show; end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit; end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Import From CSV
  def import
    # require 'csv'
    # CSV.foreach(file.path, headers: true) do |row|
    # Student.create!(row.to_hash)
    # end
    Student.import(params[:file])
    redirect_to root_url, notice: 'Student Data Imported'
  end

  # Export to CSV
  # def export
  # require 'csv'
  # file = "#{Rails.root}/public/student_data.csv"
  # students = Student.order(:uin)
  # headers = ["firstName", "lastName", "email", "uin", "year", "major", "gpa",  "status"]
  # CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
  # students.each do |student|
  # writer << [student.firstName, student.lastName, student.email, student.uin, student.year, student.major, student.gpa, student.status]
  # end
  # end

  # students = Student.all;0

  # respond_to do |format|
  # format.html
  # format.csv {send_data @students.to_csv, filename: "Students-#{Date.today}.csv"}
  # end
  # headers = "firstName,lastName,email,uin,year,major,gpa,status"
  # File.open(file, 'w') do |writer|
  # writer << headers
  # students.each do |student|
  # writer << [student.firstName, student.lastName, student.email, student.year, student.major, student.gpa, student.status]
  # writer << "\n"
  # end
  # end

  # send_file(file)
  # redirect_to root_url, notice: "Student Data Exported"
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:firstName, :lastName, :email, :uin, :year, :major, :gpa, :status)
  end
end
