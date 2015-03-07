Rails.application.routes.draw do

  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end

  unauthenticated do
    as :user do
      root to: 'static_pages#home'
    end
  end

  #get 'static_pages/home'
  get '/ldap' => 'static_pages#ldap', as: 'ldap'
  get '/about' => 'static_pages#about' , as: 'about'
  get '/faq' => 'static_pages#faq', as: 'faq'

  devise_for :users,
             path_names: { sign_out: "logout"}


  # profile_student_path
  get '/user/student/profile/:id' => 'students#profile', as: 'profile_student'
  # profile_teacher_path
  get '/user/teacher/profile/:id' => 'teachers#profile', as: 'profile_teacher'

  get '/teacher/profile/add_project' => 'teachers#add_project', as: 'add_project'
  get '/teacher/dashboard' => 'teachers#dashboard'

  #Ανάθεσης θέματος
  post 'projects/:id/assigning' => 'projects#update_assignment', as: 'project_assigning'
  post 'projects/:id/create' => 'projects#create_assignment'  # button_to 'Εκδήλωση ενδιαφέροντος',{action: "create_assignment" }, {class: "btn btn-success"}
  post 'projects/:id/destroy' => 'projects#destroy_assignment' # button_to 'Εκδήλωση ενδιαφέροντος',{action: "destroy_assignment" }, {class: "btn btn-success"}
  post 'projects/:id/delete_assignments' => 'projects#delete_assignments', as: 'delete_project_assignments' # διαγραφή συσχέτισης
  post 'projects/:id/prolongation' => 'projects#project_prolongation', as: 'project_prolongation'
  post 'projects/:id/completed' => 'projects#project_completed', as: 'project_completed'
  get 'search' => 'projects#search', as: 'project_search'

  get 'archive' => 'projects#archive', as: 'archive'
  resources :projects
  resources :users, only: [ :new, :edit, :update ]
  resources :students, path: '/user/student', only: [:edit]

  resources :teachers, path: '/user/teacher' do
    get '/projects' => 'teachers#projects'
    get '/projects/:id/edit' => 'teachers#edit_project', as: 'edit_project'
  end


  # error pages
  get "/404", :to => "static_pages#not_found"
  get "/422", :to => "static_pages#unacceptable"
  get "/500", :to => "static_pages#internal_error"


end
