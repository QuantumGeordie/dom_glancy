Rails.application.routes.draw do
  resources :local
  root :to => 'local#index'
end