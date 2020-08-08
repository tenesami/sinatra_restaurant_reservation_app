class UsersController < ApplicationController
    
    #render the login page (form)
    get '/login' do
        
        erb :login
        
    end

    #receive the login form, find the user, and log 
    #the user in (create a session)
    post '/login' do
        @user = User.find_by(email: params[:email])

        #Authenticate the user 
        if @user.authenticate(params[:password])
            #create a sessions 
           session[:user_id] = @user.id #actually log user in
           puts sessions
           redirect "users/#{@user.id}"
        else

        end

    end  

    #render the sign up form 
    get '/signup' do
        #erb (render) a view
        erb :signup

    end

    post '/users' do
        if params[:user_name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user_id #login the user
            redirect "/users/#{@user.id}"
        else
            #it would be better telling user what is wrong 
            redirect '/signup'
        end
        #{"user_name"=>"nes", "email"=>"nes@", "password"=>"tes"}

        

    end

    get '/users/:id' do 
       #"this will be the user show route "
       
       @user = User.find_by(id: params[:id]) 
       #binding.pry
       erb :'/users/show'
    end

end