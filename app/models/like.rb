class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  
  validates :micropost_id, presence: true
 
  
  
end

