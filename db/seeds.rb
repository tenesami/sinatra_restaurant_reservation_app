#create user 
tesfaye = User.create(user_name: "Tesfaye", email: "tesfa@gmail.com", password: "test")
alem = User.create(user_name: "Alem", email: "alem@gmail.com", password: "test")

#make restaurant reservation
RESERVATIONENTERY.create(restaurant_name: "Nile Etho Restaurant", description: "We will be there at 7.PM and two person sits", user_id: tesfaye.id)

tesfaye.reservation_enteries(restaurant_name: "Africana Restaurant", description: "At 1.00PM  and 4 persons sits")

alem_entry =  alem.reservation_enteries.build(restaurant_name: "Etho peace", description: "2:00pm for 3 persons sit")
alem_entry.save

