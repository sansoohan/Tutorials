Rails.application.routes.draw do
  namespace :pages do
    get 'room/index'
    post 'room/index'
    get 'home/index'
    post 'home/index'
    get 'register/index'
    post 'register/index'
    get 'login/index'
    post 'login/index'
  end
  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
