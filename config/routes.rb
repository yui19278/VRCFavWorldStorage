Rails.application.routes.draw do
  root "home#index"

  resources :worlds do
    collection do
      # vrcAPIの検索
      get :search
    end
  end
  # tag作成と一覧取得
  resources :users, only: [:index :create]
end
