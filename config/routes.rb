Gpx::Application.routes.draw do
  scope ENV['RAILS_RELATIVE_URL_ROOT'] || '' do


    root :to => 'segments#index'
  end
end
