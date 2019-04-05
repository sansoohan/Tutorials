Rails.application.routes.draw do
  namespace :pages do
    get 'home/index'
    get 'register/index'
    post 'register/index'
    get 'login/index'
    post 'login/index'
  end
  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
