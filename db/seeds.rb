#create user 
tesfaye = User.create(user_name: "Tesfaye", email: "tesfa@gmail.com", password: "test")
alem = User.create(user_name: "Alem", email: "alem@gmail.com", password: "test")

#makes restaurant reservation 
ReservationEntry.create(restaurant_name: "chili's ", numOfTable: "2", user_id: tesfaye.id)

# makes restaurant reservation using AR to pre-associate data:
tesfaye.reservation_entries.create(restaurant_name: "Bamboo sushi", numOfTable: "2")

alem_entry =  alem.reservation_entries.build(restaurant_name: "Nile", numOfTable: "4")
alem_entry.save

