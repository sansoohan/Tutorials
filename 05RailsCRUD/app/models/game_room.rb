class GameRoom < ApplicationRecord
    has_many :ships, :class_name => "Ship"
end
