class ReservationEntriesController < ApplicationController
    
#show  out all the reservation entries
    get '/reservation_entries' do
        @reservation_entries = ReservationEntry.all
        erb :'/reservation_entries/index'
      end

    #read the new form reservation entry
    # get reservation_entries/new to render a form to create new entry
    get '/reservation_entries/new' do
        redirect_if_not_logged_in
        erb :'/reservation_entries/new'
    end
   
    #create or post reservation_entries to create a new journal entry
    post '/reservation_entries' do
        #redirect to the home page _if_not_logged_in
        redirect_if_not_logged_in
        
        if params[:restaurant_name] != ""
            # create a new entry
            @reservation_entry = ReservationEntry.create(
                restaurant_name: params[:restaurant_name], 
                numOfTable: params[:numOfTable],
                user_id: current_user.id)
                # notiafay users if they created reservation succesfully 
                #if reservation.id is created 
            flash[:message] = "You Successfully Reserev restaurant tabel." if @reservation_entry.id
            redirect "/reservation_entries/#{@reservation_entry.id}"
        else
            flash[:errors] = "you must provide number of table for your entry."
            redirect '/reservation_entries/new'
        end
    end

    # show route for a journal entry
    get '/reservation_entries/:id' do
        set_reservation_entry
        erb :'/reservation_entries/show'
    end

    # Send us to reservation_entries/edit.erb, which will
    # render an edit form
    get '/reservation_entries/:id/edit' do

        redirect_if_not_logged_in
        set_reservation_entry
        if authorized_to_edit?(@reservation_entry)
            erb :'/reservation_entries/edit'
        else
            redirect "/users/#{current_user.id}"
        end
    end

    #find the reservation entry, update the reservation entry, redirect to show page
    patch '/reservation_entries/:id' do
        redirect_if_logged_in

        set_reservation_entry
        
        if @reservation_entry.user == current_user && params[:restaurant_name] != ""  
        
        @reservation_entry.update(restaurant_name: params[:restaurant_name])
        
        redirect "/reservation_entries/#{@reservation_entry.id}"
        else
            redirect "/users/#{current_user.id}"
        end
    end

    #find the reservation entry, delete the reservation entry redirect 
    #reservation entries
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
    #helper method
    def set_reservation_entry
        @reservation_entry = ReservationEntry.find(params[:id])
    end


end