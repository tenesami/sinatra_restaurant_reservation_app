class ReservationEntriesController < ApplicationController
    
    get '/reservation_entries' do
        @reservation_entries = ReservationEntry.all  
       
        erb :'/reservation_entries/index'
    end

    get '/reservation_entries/new' do
        redirect_if_not_logged_in
        erb :'/reservation_entries/new'
    end
   
    
    post '/reservation_entries' do
        
        redirect_if_not_logged_in
       
        if params[:restaurant_name] != "" && params[:numOfTable] != ""
            @reservation_entry = current_user.reservation_entries.build(  
                restaurant_name: params[:restaurant_name], 
                numOfTable: params[:numOfTable])
                
            flash[:message] = "You Successfully Reserev restaurant tabel." if @reservation_entry.id
            redirect "/reservation_entries/#{@reservation_entry.id}"
        else
            flash[:errors] = "you must provide valid entry for your reservation" 
            redirect '/reservation_entries/new'
        end
    end

    
    get '/reservation_entries/:id' do
        set_reservation_entry
        erb :'/reservation_entries/show'
    end


    get '/reservation_entries/:id/edit' do
        redirect_if_not_logged_in
        set_reservation_entry
        
        if authorized_to_edit?(@reservation_entry)
            erb :'/reservation_entries/edit'
        else       
            redirect "/users/#{current_user.id}"
        end
    end


    patch '/reservation_entries/:id' do
        redirect_if_not_logged_in

        set_reservation_entry
        
        if @reservation_entry.user == current_user && params[:restaurant_name] != ""  
        
        @reservation_entry.update(restaurant_name: params[:restaurant_name])
        @reservation_entry.update(numOfTable: params[:numOfTable])
    
        redirect "/reservation_entries"
        else
            redirect "/users/#{current_user.id}"
        end
    end

    
    delete '/reservation_entries/:id' do
        set_reservation_entry
        if authorized_to_edit?(@reservation_entry)
            @reservation_entry.destroy
            flash[:message] = "Successfully deleted that entry."
            redirect '/reservation_entries'
         else
            redirect '/reservation_entries'
        end
    end


    private 
    def set_reservation_entry
        @reservation_entry = ReservationEntry.find_by(params[:id])
    end
end