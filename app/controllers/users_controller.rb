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
           sessions[:user_id] = @user.id #actually log user in
           puts session
           redirect "user/#{user.id}"
        else

        end

    end  

    get '/signup' do
    end

    get '/user/:id' do 
       "this will be the user show route " 
    end

end