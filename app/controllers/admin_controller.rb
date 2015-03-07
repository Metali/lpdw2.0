class AdminController < ApplicationController
  #Before any action just authetificate user
  before_action :authenticate_user!, :is_admin

  #user Controller
  def create_user
    @title_admin = "Utilisateur"
    @user = User.new
  end
  def index
    @title_admin = "Dashboard"
    @users = User.all
    @projects = Project.all
    @alerts = Alert.all
    @applicants = Applicant.all
  end
  def show_users
    @title_admin = "Utilisateurs"
    @users = User.all
  end
  def edit_user
    @title_admin = "Utilisateur"
    @user=User.find(params[:id])
  end
  def update_user
    @title_admin = "Utilisateur"
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user].permit(:email, :password, :password_confirmation, :role, :name, :lastname, :twitter, :description, :photo, :linkin))
      # Handle a successful update.
      flash["sucess"] ="Mis a jour avec succès"
      redirect_to admin_show_users_path
    else
      flash[:error] = @user.errors.messages[:email].to_s + @user.errors.messages[:password].to_s +  @user.errors.messages[:password_confirmation].to_s + @user.errors.messages[:photo].to_s
      redirect_to admin_edit_user_path(@user)
    end
  end
  def delete_user
    @user=User.find(params[:id])
    if @user.destroy
      flash["sucess"] ="SUCESS DELETE"
      redirect_to admin_show_users_path()
    else
      flash[:error] =  @user.errors.messages[:email] + @user.errors.messages[:password] +  @user.errors.messages[:password_confirmation] + @user.errors.messages[:photo]
      redirect_to admin_show_users_path()
    end
  end

  def new
    @user = User.new(params[:user].permit(:email, :password, :password_confirmation, :role, :name, :lastname))
    if @user.save
      flash["success"] ="User created"
      redirect_to admin_show_users_path()
    else
      flash[:error] =  @user.errors.messages[:email].to_s + @user.errors.messages[:password].to_s +  @user.errors.messages[:password_confirmation].to_s + @user.errors.messages[:photo].to_s
      redirect_to admin_create_user_path()
    end
  end

  def is_admin
    @user = current_user
    if (@user.role != "admin") then
      flash[:error] = "You must be admin to access this section"
      redirect_to root_path # halts request cycle
    end
  end


  # applicants controller
  def show_applicants
    @title_admin = "Candidatures"
    @applicants = Applicant.all
  end

  def show_applicant
    @title_admin = "Voir un étudiant"
    @applicant = Applicant.find(params[:id])
    @cursus = @applicant.cursus
    @application = @applicant.other_application
    @experience = @applicant.professional_experiences
    @projects = @applicant.project_applicants
    @votes = @applicant.votes
    @status = @applicant.applicant_statuses
  end

  # actuality Controller
  before_action :get_this_actuality,only: [:edit_actuality,:update_actuality,:delete_actuality]
  def get_this_actuality
    @thisActuality = Actuality.find(params[:id])
  end

  def show_actualities
    @title_admin = "Actualités"
    @actualities = Actuality.all
  end
  def create_actuality
    @title_admin = "Actualité"
    @actuality = Actuality.new
  end

  def create_tinymce_assets
    geometry = Paperclip::Geometry.from_file params[:file]
    image    = Image.create params.permit(:file, :alt)

    renderJson = {
      image: {
        url:    image.file.url
      }
    }

    render json: renderJson, content_type: "text/html"
  end

  def new_actuality
    @title_admin = "Actualité"
    @actuality = Actuality.new(params[:actuality].permit(:title, :content, :author))
    if @actuality.save
      flash["sucess"] = "Actuality created"
      redirect_to admin_show_actualities_path() # halts request cycle
    else
      flash["fail"] = "Actuality not created"
      redirect_to admin_create_actuality_path() # halts request cycle
    end
  end

  def edit_actuality
    @title_admin = "Actualité"
  end
  def update_actuality
    @title_admin = "Actualité"
    if @thisActuality.update_attributes(params[:this].permit(:title, :content, :author))
      # Handle a successful update.
      flash["sucess"] ="Mis a jour avec succès"
      redirect_to admin_show_actualities_path
    else
      redirect_to admin_edit_actuality_path(thisActuality)
    end
  end
  def delete_actuality
    if @thisActuality.destroy
      flash["sucess"] ="SUCESS DELETE"
      redirect_to admin_show_actualities_path()
    else
      flash["fail"] = "Delete Fail"
      redirect_to admin_show_actualities_path()
    end
  end

  #alert controller
  before_action :get_this_alert,only: [:edit_alert,:update_alert,:delete_alert]
  def get_this_alert
    @thisAlert = Alert.find(params[:id])
  end

  def create_alert
    @alert = Alert.new
  end

  def new_alert
    @alert = Alert.new(params[:alert].permit(:name,:content,:level,:active))
    if @alert.save
      flash["sucess"] ="Alert created"
      redirect_to admin_show_alerts_path()
    else
      flash["fail"] = "Fail to create alert"
      redirect_to admin_create_alert_path()
    end
  end
  def show_alerts
    @title_admin = "Alertes"
    @alerts = Alert.all
  end

  def edit_alert
    @title_admin = "Alerte"
    @actuality=@thisAlert
  end
def update_alert
    @title_admin = "Alerte"
    if @thisAlert.update_attributes(params[:thisAlert].permit(:name,:content,:level,:active))
      # Handle a successful update.
      flash["sucess"] ="Mis a jour avec succès"
      redirect_to admin_show_alerts_path()
    else
      redirect_to admin_edit_alert_path(@thisAlert)
    end
  end
  def delete_alert
    if @thisAlert.destroy
      flash["sucess"] ="SUCESS DELETE"
      redirect_to admin_show_alerts_path()
    else
      flash["fail"] = "Delete Fail"
      redirect_to admin_show_alerts_path()
    end
  end

  # Projects Controller
  before_action :get_this,only: [:edit_project,:update_project,:delete_project]
  def get_this
    @this = Project.find(params[:id])
  end

  def show_projects
    @title_admin = "projects"
    @projects = Project.all
  end
  def create_project
    @title_admin = "projects"
    @project = Project.new
  end

  def create_tinymce_assets
    geometry = Paperclip::Geometry.from_file params[:file]
    image    = Image.create params.permit(:file, :alt)

    renderJson = {
      image: {
        url:    image.file.url
      }
    }

    render json: renderJson, content_type: "text/html"
  end

  def new_project
    @title_admin = "Project"
    @project = Project.new(params[:project].permit(:photo, :name, :description, :link, :thumbmail))
    if @project.save
      flash[:info] = "Project created"
      redirect_to admin_show_projects_path() # halts request cycle
    else
      flash[:error] = "Project not created"
      redirect_to admin_create_project_path() # halts request cycle
    end
  end

  def edit_project
    @title_admin = "Project"
    @project=@this
  end
  def update_project
    @title_admin = "project"
    if @this.update_attributes(params[:this].permit(:photo, :name, :description, :link, :thumbmail))
      # Handle a successful update.
      flash[:info] ="Mis a jour avec succès"
      redirect_to admin_show_projects_path
    else
      flash[:error] = @this.messages.errors
      redirect_to admin_edit_project_path(this)
    end
  end
  def delete_project
    if @this.destroy
      flash["sucess"] ="SUCESS DELETE"
      redirect_to admin_show_projects_path()
    else
      flash[:error] = @this.messages.errors
      redirect_to admin_show_projects_path()
    end
  end

end
