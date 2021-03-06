Rails.application.routes.draw do


  #devise_for :users, :path => '', :path_names => {sign_in: 'admin/login', sign_out:  'logout', sign_up: 'create'}

devise_for :users, :controllers => {:sessions => "sessions"},
path: '/',
:path_names => {
    :sign_in  => 'login',
    :sign_up  => 'sign_up',
    :sign_out => 'logout'
  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".SSS

  root 'pages#home'
  resources :actualities, only: [:index, :show]
  resources :tips, only: [:index, :show]
  resources :password_resets
    
  namespace :admin_v2 do
    resources :actualities, except: [:show]
    resources :users, except: [:show]
    resources :projects, only: [:new ,:create ,:edit ,:update, :destroy ,:index]
    resources :tips, only: [:new ,:create ,:edit ,:update, :destroy ,:index]
    resources :tipcategories, only: [:new ,:create ,:edit, :destroy ,:index]
    resources :alerts, only: [:new ,:create ,:edit ,:update, :destroy ,:index]
    resources :interview, only: [:new ,:create ,:index]
    resources :applicants, only: [:index,:show]
    resources :admin, only: [:index,:new]
    resources :companies, only: [:new ,:create ,:edit ,:update, :destroy ,:index]
    resources :jobs, only: [:new ,:create ,:edit ,:update, :destroy ,:index]
    resources :admin, only: [:index]
 end

  resource :applicant, only: [:new, :create, :edit, :update, :show]
  resource :user, only: [:edit,:update]

  # get 'admin/show_applicants' => 'admin#show_applicants'
  # get 'admin/show_applicant/:id' => 'admin#show_applicant', :as => 'admin_show_applicant'

  post 'admin_v2/applicants/index/user_vote' => 'admin#user_vote', :as => 'user_vote'
  post 'admin_v2/applicants/index/user_vote_cancel' => 'admin#user_vote_cancel', :as => 'user_vote_cancel'

  post 'admin/show_applicants/applicant_complete', :to => 'admin#applicant_complete', :as => 'applicant_complete'
  post 'admin/show_applicants/ok_for_interview', :to => 'admin#ok_for_interview', :as => 'ok_for_interview'
  post 'admin/show_applicants/is_refused', :to => 'admin#is_refused', :as => 'is_refused'
  post 'admin/show_applicants/is_accepted', :to => 'admin#is_accepted', :as => 'is_accepted'
  post 'admin/show_applicants/applicant_finish', :to => 'admin#applicant_finish', :as => 'applicant_finish'
  post 'admin/show_applicants/interview_result', :to => 'admin#interview_result', :as => 'interview_result'
  post 'admin/show_applicants/user_destroy', :to => 'admin#user_destroy', :as => 'user_destroy'
  get 'admin_v2/enable/:id' => 'admin_v2/jobs#enable', :as => 'admin_v2_enable_job'
  get 'admin_v2/disable/:id' => 'admin_v2/jobs#disable', :as => 'admin_v2_disable_job'

  get 'admin' => 'admin#index'
  get 'admin/sign_up' => 'admin#index'
  get 'admin/student_old/:id/graduate_student' => 'admin#graduate_student', :as => 'admin_graduate_student'
  post 'admin/tinymce_assets' => 'admin#create_tinymce_assets'
  post 'admin/tinymce_assets' => 'admin#create_tinymce_assets'
  post 'admin/show_applicants/send_remind', :to => 'admin#send_remind', :as => 'send_remind'



  get 'admin/show_options' => 'admin#show_options'
  get 'admin/show_options' => 'admin#show_options'
  post 'admin/update_options' => 'admin#update_options'

  # routes annuaire etudiant
  get '/annuaire' => 'companies#annuary', :as => 'annuary'
  get '/entreprises/:page' => 'companies#companies', :as => "companies", defaults: { page: 1 }
  get '/entreprise/:id' => 'companies#company', :as => "company"
  get '/offres/:page' => 'jobs#jobs', :as => 'jobs', defaults: {page: 1}
  get '/offre/:id' => 'jobs#job', :as => 'job'

  get '/', :to => 'pages#home'
  get '/formation', :to => 'pages#formation'
  get '/projets', :to => 'pages#project'
  get '/equipe', :to => 'pages#team'
  get '/ucp', :to => 'pages#ucp'
  get '/informations', :to => 'pages#map'
  post '/informations/sendmail', :to => 'pages#sendmail'
  get '/postuler', :to => 'applicants#new'
  post '/postuler/login', :to => 'applicant#applicant_login', :as => 'applicant_login'
  get '/postuler/:assurance', :to => 'applicant#applicant_create_apply', :as => 'applicant_create_apply'
  post '/postuler/new', :to => 'applicant#create_apply', :as => 'create_apply'
  patch '/postuler/:assurance', :to => 'applicant#update_apply', :as => 'update_apply'
  get '/mentions', :to => 'pages#mentions'
  get '/live', :to => 'pages#live'

  get '/studentsbook', :to => 'student#show', :as => 'students_list'
  get '/studentsbook/:graduation_years' , :to => 'student#show', :as => 'students_list_by_year'
  post 'studentsbook/', :to => 'student#show'
  post 'studentsbook/:graduation_years', :to => 'student#show'
  get '/studentprofil/:user_id', :to => 'student#profil', :as => 'student_profil'
  post '/studentprofil/sendmail', :to => 'student#sendmail'
  get '/studentprofil/edit/:user_id', :to => 'student#edit', :as => 'student_profil_edit'
  post '/studentprofil/update_user/:user_id', :to => 'student#update_user'
  resources :tips, only: [:show,:index] do
    resources :errors_tips
  end
end
