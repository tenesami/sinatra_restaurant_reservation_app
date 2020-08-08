class ReservationEntriesController < ApplicationController
    
    get '/reservation_entries' do
        erb :'/reservation_entries/new'
    end
   
    post '/reservation_entries/new' do
        redirect_if_not_logged_in

        if params[:restaurant_name] != ""
            @reservation_entry = ReservationEntry.create(
                restaurant_name: params[:restaurant_name], 
                user_id: current_user.id)

            redirect "/reservation_entries/#{@reservation_entry.id}"
        else
            redirect '/reservation_entries/new'
        end
    end
    get '/reservation_entries/:id' do
        @reservation_entry = ReservationEntry.find(params[:id])
        erb :'/reservation_entries/show'
    end
end