Rails.application.routes.draw do

  devise_for :users, path: "auth",
    controllers: {
      omniauth_callbacks: "omniauth_callbacks"
    },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      registration: 'register',
    }

  root "home#index"

  get 'me' => 'user#index'
  get 'me/polls' => 'user#polls'
  get 'me/voteds' => 'user#voteds'
  delete 'me/deactive' => 'user#deactive_me'

  get 'admin' => 'admin#index'
  get 'admin/reporteds' => 'admin#reporteds'
  get 'admin/users' => 'admin#users'
  put 'admin/user/:id' => 'admin#activate_user'
  delete 'admin/user/:id' => 'admin#deactive_user'
  delete 'admin/poll/:id' => 'admin#remove_poll'

  get 'search' => 'home#search'

  post 'polls' => 'poll#create'
  get 'polls/:id' => 'poll#index'
  put 'polls/:id' => 'poll#edit'
  delete 'polls/:id' => 'poll#delete'
  post 'polls/:id/report' => 'poll#report'


  post 'options' => 'option#create'
  post 'options/multiple' => 'option#create_multiple'
  put 'options' => 'option#edit'
  delete 'options' => 'option#delete'
 

  #vote
  post 'vote' => 'vote#vote'
  #undo vote
  post 'unvote' => 'vote#unvote'
end
