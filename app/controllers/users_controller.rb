class UsersController < ApplicationController
    
    #render the login page (form)
    get '/login' do 
        redirect_if_logged_in  
        erb :login   
    end

    #receive the login form, find the user, and log 
    #the user in (new a session)
    post '/login' do
        #find the user
        @user = User.find_by(email: params[:email])

        #Authenticate the user 
        if @user && @user.authenticate(params[:password])

        #create a sessions for a login user and check wether user is login or not
           session[:user_id] = @user.id 
           
           #shows the user page 
           flash[:message] = "Welcome to our app, #{@user.user_name}!"
           redirect "users/#{@user.id}"
        else
            flash[:errors] = "Email or Password wrong please try again or signup"
            #redirect to the sign up pages to sign up 
            redirect '/login'

        end

    end  

    #render the sign up form 
    get '/signup' do
        redirect_if_logged_in
        erb :signup
    end

    # create a new user and persist the new user to the DB
    post '/users' do
        # only persist a user that has a name, email, AND password
        # ActiveRecord Validations within my user model class
        @user = User.new(params)
        if @user.save
            
            #login the user
            session[:user_id] = @user.id 
            
            flash[:message] = "you seccessfuly created an account, #{@user.user_name} !"
            redirect "/users/#{@user.id}"
        else
             
            #it tell user what is wrong 
            flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end 

    end

    #render the user show route 
    get '/users/:id' do 
       @user = User.find_by(id: params[:id]) 
       redirect_if_not_logged_in
       erb :'/users/show'
    end
    
    get '/logout' do 
        session.clear
        redirect '/'
    end
   
end