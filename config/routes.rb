Rails.application.routes.draw do

  resources :inventory_check_data_import_files do
    get :import_request, :on => :member
    resources :inventory_check_data_import_results, :only => [:index, :show, :destroy]
  end

  resources :inventory_shelf_barcode_import_files do
    get :import_request, :on => :member
    resources :inventory_shelf_barcode_import_results, :only => [:index, :show, :destroy]
  end

  resources :inventory_manages do
    resources :inventory_shelf_groups
    resources :inventory_shelf_barcodes

    resources :inventory_check_data
    resources :inventory_check_results
    resource :inventory_checks
    resource :inventory_update_items do
      get :index, :on => :member
      get :bulk_edit, :on => :member
      post :bulk_update, :on => :member
      get :unit_edit, :on => :member
      post :unit_update, :on => :member
    end

    resources :inventory_update_histories

    get :finish, :on => :member
    put :finished, :on => :member
  end
end
