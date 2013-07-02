Rails.application.routes.draw do
  resources :inventory_shelf_barcode_import_files


  resources :inventory_manages do
    resources :inventory_shelf_groups
    resources :inventory_check_datas
    resources :inventory_check_results
    resources :inventory_shelf_barcodes
    resource :inventory_checks

    get :finish, :on => :member
    put :finished, :on => :member
  end
end
