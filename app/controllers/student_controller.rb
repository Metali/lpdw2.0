class StudentController < ApplicationController
  def show
    @graduationYears = UsersInfo.select("graduation_year").order("graduation_year").all
    if(params[:graduation_years] == nil)
      @student = User.students.select {|student| student.users_info.graduation_year == 0}
    else
      @student = User.students.select {|student| student.users_info.graduation_year == params[:graduation_years].to_i}
    end
  end

  def profil
      @student = User.students.find(params[:user_id])
  end

  def edit
    @student = User.students.find(params[:user_id])
  end
end