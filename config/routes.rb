Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #resources :resumes, only: [:index, :new, :create, :destroy]
 
	 resources :resumes do
		  collection do
			get :listar_horarios
		  end
	 end
  
  
  root "resumes#index"
  get 'timeline' => 'resumes#timeline'
end
