class UsersController < ApplicationController
    
    #render the login page (form)
    get '/login' do 
        redirect_if_logged_in  
        erb :login   
    end

    #receive the login form, find the user, and log 
    #the user in (new a session)
    post '/login' do
        @user = User.find_by(email: params[:email])

        #Authenticate the user 
        if @user && @user.authenticate(params[:password])
            #create a sessions and login user 
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
        #erb (render) a view
        erb :signup

    end

    post '/users' do
        # only persist a user that has a name, email, AND password
        # ActiveRecord Validations within my user model class
        @user = User.new(params)
        if @user.save
            
            #login the user
            session[:user_id] = @user_id 
            
            flash[:message] = "you seccessfuly created an account, #{@user.user_name} !"
            redirect "/users/#{@user.id}"
        else
             
            #it telling user what is wrong 
            flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end 

    end

    get '/users/:id' do 
       #"this will be the user show route "
       
       @user = User.find_by(id: params[:id]) 
       
       redirect_if_not_logged_in

       erb :'/users/show'
    end
    
    get '/logout' do 
        session.clear
        redirect '/'
    end
   
end