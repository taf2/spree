Rails.application.routes.draw do
  resources :users, :only => [:edit, :update]
  devise_for :users,
             :controllers => { :sessions => 'user_sessions',
                               :registrations => 'user_registrations',
                               :passwords => "user_password_resets"},
             :path_names => { :sign_out => 'logout'}

  devise_scope :user do
    get "/login" => "user_sessions#new", :as => :login
    get "/signup" => "user_registrations#new", :as => :signup
  end


  match '/checkout/registration' => 'checkout#registration', :via => :get, :as => :checkout_registration
  match '/checkout/registration' => 'checkout#update_registration', :via => :put, :as => :update_checkout_registration

  match '/orders/:id/token/:token' => 'orders#show', :via => :get, :as => :token_order

  resource :session do
    member do
      get :nav_bar
    end
  end
  resource :account, :controller => "users"

end
