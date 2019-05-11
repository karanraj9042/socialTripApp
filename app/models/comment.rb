#comments model which has many to one relationship ith user and message.
class Comment < ApplicationRecord
  belongs_to :message
  belongs_to :user
  
end
