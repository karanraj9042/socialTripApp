class Message < ApplicationRecord
    belongs_to :user
    has_many :comments
    
    validates :title, :description, presence: true
end
