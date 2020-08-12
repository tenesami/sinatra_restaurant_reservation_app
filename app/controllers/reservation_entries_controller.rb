class ReservationEntriesController < ApplicationController
    

    get '/reservation_entries' do
        @reservation_entries = ReservationEntry.all
        erb :'/reservation_entries/index'
      end

    get '/reservation_entries/new' do
        erb :'/reservation_entries/new'
    end
   
    post '/reservation_entries' do
        #redirectto the home page _if_not_logged_in
        redirect_if_logged_in
        
        if params[:restaurant_name] != ""

            @reservation_entry = ReservationEntry.create(
                restaurant_name: params[:restaurant_name], 
                user_id: current_user.id)
            flash[:message] = "Successfully Resreve Tabel." if @reservation_entry.id
            redirect "/reservation_entries/#{@reservation_entry.id}"
        else
            redirect '/reservation_entries/new'
        end
    end

    get '/reservation_entries/:id' do
        set_reservation_entry
        erb :'/reservation_entries/show'
    end


    get '/reservation_entries/:id/edit' do
        set_reservation_entry
        redirect_if_not_logged_in
    
        if authorized_to_edit?(@reservation_entry)
            erb :'/reservation_entries/edit'
        else
            redirect "/users/#{current_user.id}"
        end
    end

    
    patch '/reservation_entries/:id' do
        set_reservation_entry
        redirect_if_logged_in
    
        if authorized_to_edit?(@reservation_entry) && params[:restaurant_name] != ""  
        
        @reservation_entry.update(restaurant_name: params[:restaurant_name])
        
        redirect "/reservation_entries/#{@reservation_entry.id}"
        else
            redirect "/users/#{current_user.id}"
        end
    
    end

    delete '/reservation_entries/:id' do
        set_reservation_entry
        if authorized_to_edit?(@reservation_entry)
            @reservation_entry.destroy
            redirect '/reservation_entries'
         else
            redirect '/reservation_entries'
        end
    end
    private 
    #helper method
    def set_reservation_entry
        @reservation_entry = ReservationEntry.find(params[:id])
    end


end