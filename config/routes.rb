Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root :to => "homes#top"

resources :books, only: [:index, :show, :edit, :create, :destroy, :update]
resources :users, only: [:index, :show, :edit, :update]

get 'homes/top'
#homes/aboutをhome/aboutにするだけ(重要：ルーティングがhomesでも問題なし)
get 'home/about' => 'homes#about', as: 'about'

end
