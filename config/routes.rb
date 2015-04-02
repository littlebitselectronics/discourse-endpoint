DiscourseEndpoint::Engine.routes.draw do
  resource :users do
    collection do
      get 'current'
      get 'fetch_nav'
    end
  end
end
