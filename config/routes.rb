Rails.application.routes.draw do

  get '/videos' => 'videos#index'
  get '/songs'  => 'songs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
