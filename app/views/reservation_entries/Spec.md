[X] Build an MVC Sinatra application. I used 
[X] Use ActiveRecord with Sinatra i.e I used Active record to stor the information in the database
[X] Use multiple models models i.e I used two model 1.user 2.resevation_enrty
[X] Use at least one has_many relationship on a User model and one belongs_to relationship on another model. i.e I Include has_many relationship on my User model (e.g. User has_many restaurant reservation entry). I also Include one belongs_to relationship on restaurant reservation model (e.g. restaurant_reservation belongs_to User) 
[X] Must have user accounts - users must be able to sign up, sign in, and sign out.Include user accounts with unique login attribute (username or email) 
[X] Validate uniqueness of user login attribute (username or email). i.e I used gem 'bcrypt' to create unique password 
[X] Once logged in, a user must have the ability to create, read, update and destroy the resource that belongs_to user. i.e user can create restaurant reservation, can edit their own reservation, can also delete their reservation, and also can update reservation.
[X] Ensure that users can edit and delete only their own resources - not resources created by other users. i.e use conditions to ensure users are login and rederect only to their page by chacking their reservation entry id 
[X] Validate user input so bad data cannot be persisted to the database. e.g user can not create balnk reservation 
[X]BONUS: Display validation failures to user with error messages. (This is an optional feature, challenge yourself and give it a shot!)

 