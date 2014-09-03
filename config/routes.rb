Instaqueue::Application.routes.draw do

  root "dynamic#index"

  # json API
  scope '/api' do
    resources :posts, defaults: { format: :json }
  end

end