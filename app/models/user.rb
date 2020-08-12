class User < ActiveRecord::Base 
    has_secure_password

    validates :user_name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many :reservation_entries
end