Rails.application.routes.draw do
  match 'kracker'           => "kracker#index"
  match 'kracker/config'    => "kracker#path_config"
  match 'kracker/artifacts' => "kracker#artifacts"
  match 'kracker/about'     => 'kracker#about'

  resources :kracker
end