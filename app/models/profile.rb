require_relative 'nullmodels/null_user.rb'
class Profile < ApplicationRecord
  belongs_to :user
  #validate firstname,lastname,address,likedeb=vent,likedvenue and if their presence is true then only profile ill be saved.
  validates :firstname,  presence: true
  validates :lastname,   presence: true
  validates :address,    presence: true
  validates :likedevent, presence: true 
  validates :likedvenue, presence: true 
  validates :user_id,    presence: true
  
  #nil object design pattern for a profile if user is null
  def user
    super || NullUser.new
  end
end
