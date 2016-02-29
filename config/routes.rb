Rails.application.routes.draw do
  resources :api, only: [], defaults: { format: :json } do
    collection do
      resources :plugin, only: [] do
        collection do
          resources :tv, controller: 'hive_mind_tv/api', only: [] do
            collection do
              put 'set_application'
            end
          end
        end
      end
    end
  end
end
