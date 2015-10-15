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

  def sendmail
    if params["contact_email"] != "" and params["contact_object"] != "" and params["contact_message"] != ""
      begin
        user = User.find(params[:contact_user_id])
        Emailer.contact_old_student(params, user.email).deliver
      rescue Exception => e
        flash["error"] = "Pas cool !!"
      end
    else
      flash["error"] = "Vous deviez remplir les champs"
    end
    flash["success"] = "Message envoyé"
    redirect_to students_list_path
  end

  def edit
    @student = User.students.find(params[:user_id])
  end

  def update_user
    sql = "UPDATE users SET twitter ='"+params[:student_twitter]+"' WHERE id ="+params[:user_id]
    ActiveRecord::Base.connection.execute(sql)
    redirect_to action: 'edit'
  end
end
