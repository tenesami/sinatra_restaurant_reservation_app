require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "restauran_reservation_app"
    register Sinatra::Flash
  end

  get "/" do

    redirect_if_logged_in
    
    erb :Home
    
  end

  helpers do

    def logged_in?
       #turn the curent user to boolean, if user is logged in true, otherwise false
      !!current_user
    end

    #calls the current user if the curren user is nill
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    #helper method 
    def authorized_to_edit?(reservation_entry)
      reservation_entry.user == current_user
    end
    # use this helper method to avoid showing welcome, login, or signup page to a user that's already logged in
       # use this helper method to protect controller actions where user must be logged in to proceed
       def redirect_if_not_logged_in
        if !logged_in?
          flash[:errors] = "You must be logged in to view the page "
          redirect '/'
        end
      end
  
      # use this helper method to avoid showing welcome, login, or signup page to a user that's already logged in
      def redirect_if_logged_in
        if logged_in?
          redirect "/users/#{current_user.id}"
        end
      end
      
  end 
end
