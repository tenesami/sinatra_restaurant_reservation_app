#create user 
tesfaye = User.create(user_name: "Tesfaye", email: "tesfa@gmail.com", password: "test")
alem = User.create(user_name: "Alem", email: "alem@gmail.com", password: "test")

#make restaurant reservation
ReservationEntry.create(restaurant_name: "Nile Etho Restaurant", user_id: tesfaye.id)

tesfaye.reservation_entries.create(restaurant_name: "Africana Restaurant")

alem_entry =  alem.reservation_entries.build(restaurant_name: "Etho peace")
alem_entry.save

