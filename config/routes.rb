LearnLtiEngine::Engine.routes.draw do
  namespace :api do
    resources :assignments do
      collection do
        get 'post_params'
        get 'step_params'
        post 'step_validation'
      end
    end
  end
  post "embed" => "lti#embed", as: :lti_embed
  match "launch/:assignment_name" => "lti#launch", as: :launch, via: [:get, :post]
  get "config(.xml)" => "lti#xml_config", as: :lti_xml_config
  get "health_check" => "lti#health_check"
  match "/" => "lti#index", via: [:get, :post]
  root "lti#index"
  get "test/backdoor"
end
