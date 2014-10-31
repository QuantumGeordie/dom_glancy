Rails.application.routes.draw do
  get 'dom_glancy'                 => "dom_glancy#index"
  get 'dom_glancy/config'          => "dom_glancy#path_config"
  get 'dom_glancy/about'           => "dom_glancy#about"
  get 'dom_glancy/show/:diff_file' => "dom_glancy#show"
  get 'dom_glancy/clear'           => "dom_glancy#clear"
  post 'dom_glancy/bless'          => "dom_glancy#bless"#, :via => [:get, :post]

  get 'dom_glancy/artifacts'               => "dom_glancy#artifacts"
  get 'dom_glancy/artifacts_delete/:file'  => "dom_glancy#artifacts_delete"
  get 'dom_glancy/artifacts_expand/:file'  => "dom_glancy#artifacts_expand"

  get 'dom_glancy/make_master/:file'    => "dom_glancy#make_master"
  get 'dom_glancy/delete_current/:file' => "dom_glancy#delete_current"

  resources :dom_glancy
end
