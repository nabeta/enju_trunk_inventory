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

    resources :inventory_check_datum
    resources :inventory_check_results
    resource :inventory_checks

    get :finish, :on => :member
    put :finished, :on => :member
  end
end
