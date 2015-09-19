Rails.application.routes.draw do

  devise_for :users,
    controllers: {
      omniauth_callbacks: "omniauth_callbacks"
    },
    path: "auth",
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


  get 'search' => 'home#search'


  post 'polls' => 'poll#create'
  get 'polls/:id' => 'poll#index'
  put 'polls/:id' => 'poll#edit'
  delete 'polls/:id' => 'poll#delete'


  post 'options' => 'option#create'
  post 'options/multiple' => 'option#create_multiple'
  put 'options' => 'option#edit'
  delete 'options' => 'option#delete'
#  delete 'polls/:poll_id/options/:option_id' => 'option#delete'
 

  #vote
  post 'vote' => 'vote#vote'
  #undo vote
  post 'unvote' => 'vote#unvote'
end
