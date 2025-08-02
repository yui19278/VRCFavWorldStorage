Rails.application.routes.draw do
  get "homes/index"
  root "homes#index"

  resources :worlds do
    collection do
      # vrcAPIの検索
      get :search
    end
  end
  # tag作成と一覧取得
  resources :tags, only: [ :index, :create ]
end
