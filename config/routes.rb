InstahashOauth::Application.routes.draw do

  
  root :to => 'feed#index'
  # get 'feed/index'

  match "session/:action", :to => "sessions"
  # match :controller => "sessions", :action => "connect"
  
  get '/index', :controller => "feed", :action => "index"

  get '/home' => 'feed#home', :as => :home
  get '/recent' => 'feed#recent', :as => :recent
  get '/show/:id' => 'feed#show', :as => :show
  get '/home/next' => 'feed#home', :as => :next
  get '/home/back' => 'feed#back', :as => :back

end
  