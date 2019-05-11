Rails.application.routes.draw do
  
  
  
  
  resources :messages do
    resources :comments
  end  
  resources :profiles
  resources :trips do
    resources :customweathers
    resources :caffes
    resources :eventsnearbies
  end
  root 'home#index'
  get '/signedinuserprofile' => 'profiles#signedinuserprofile'
  get "/trip/:id/likedvenue" => 'trips#likedvenue'
  get "/trip/:id/likedevent" => 'trips#likedevent'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", 
                                       registrations: "registration",
                                       passwords: "password_captcha"}
                                       
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 