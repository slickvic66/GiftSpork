Giftr::Application.routes.draw do

  # REV: got a lot of lines with trailing spaces.
  devise_for :users, :path => "accounts", 
                     :path_names => { :sign_in => "login", 
                                      :sign_out => "logout", 
                                      :sign_up => "register" }

  resources :users do
    resource :profile
  end

  resources :memberships, :only => [:create]
  resources :exchanges do
      post :make_matches, :on => :member
      resources :gifts, :only => [:index], :on => :member do 
        # REV: what is `add_gift`?
        post :add_gift, :on => :member
      end
  end


  # REV: put root first in your routes
  root to: "static_pages#home"

  # REV: You can create a `resource static_pages` and just add `get
  # :contact` as a member route.
  get "/contact", to: "static_pages#contact"
  get "/faq", to: "static_pages#faq"

  # REV: always delete the documentation Rails shoves in config/routes.rb
end
