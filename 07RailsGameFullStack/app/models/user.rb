class User < ApplicationRecord
    validates :user_name, uniqueness: true
end
