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
  #get 'static_pages/help'
  devise_for :users,
             path_names: { sign_out: "logout"}


  # profile_student_path
  get '/user/student/profile/:id' => 'students#profile', as: 'profile_student'
  # profile_teacher_path
  get '/user/teacher/profile/:id' => 'teachers#profile', as: 'profile_teacher'

  get '/teacher/profile/add_project' => 'teachers#add_project', as: 'add_project'
  get '/teacher/dashboard' => 'teachers#dashboard'

  #Ανάθεσης θέματος
  #post 'projects/:id' => 'projects#project_assignments'
  post 'projects/:id/assigning' => 'projects#update_assignment', as: 'project_assigning'
  post 'projects/:id/create' => 'projects#create_assignment'  # button_to 'Εκδήλωση ενδιαφέροντος',{action: "create_assignment" }, {class: "btn btn-success"}
  post 'projects/:id/destroy' => 'projects#destroy_assignment' # button_to 'Εκδήλωση ενδιαφέροντος',{action: "destroy_assignment" }, {class: "btn btn-success"}

  resources :projects
  resources :users, only: [ :new, :edit, :update ]
  resources :students, path: '/user/student', only: [:edit]

  resources :teachers, path: '/user/teacher' do
    get '/projects' => 'teachers#projects'
    get '/projects/:id/edit' => 'teachers#edit_project', as: 'edit_project'
  end



=begin
  get 'profile'         => 'users#profile'
  get 'profile/edit'    => 'users#edit'
  get 'profile/:id'     => 'users#show'
=end


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
     #resources :users
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
