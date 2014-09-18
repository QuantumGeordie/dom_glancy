Rails.application.routes.draw do
  get 'kracker'                 => "kracker#index"
  get 'kracker/config'          => "kracker#path_config"
  get 'kracker/about'           => "kracker#about"
  get 'kracker/show/:diff_file' => "kracker#show"
  get 'kracker/clear'           => "kracker#clear"
  post 'kracker/bless'         => "kracker#bless"#, :via => [:get, :post]

  get 'kracker/artifacts'               => "kracker#artifacts"
  get 'kracker/artifacts_delete/:file'  => "kracker#artifacts_delete"
  get 'kracker/artifacts_expand/:file'  => "kracker#artifacts_expand"

  get 'kracker/make_master/:file'    => "kracker#make_master"
  get 'kracker/delete_current/:file' => "kracker#delete_current"

  resources :kracker
end
