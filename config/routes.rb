Rails.application.routes.draw do
  match 'kracker'                 => "kracker#index"
  match 'kracker/config'          => "kracker#path_config"
  match 'kracker/about'           => "kracker#about"
  match 'kracker/show/:diff_file' => "kracker#show"
  match 'kracker/clear'           => "kracker#clear"
  match 'kracker/bless'           => "kracker#bless"

  match 'kracker/artifacts'               => "kracker#artifacts"
  match 'kracker/artifacts_delete/:file'  => "kracker#artifacts_delete"
  match 'kracker/artifacts_expand/:file'  => "kracker#artifacts_expand"

  match 'kracker/make_master/:file'    => "kracker#make_master"
  match 'kracker/delete_current/:file' => "kracker#delete_current"

  resources :kracker
end