class Blocker < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :description
  validates_length_of :description, :maximum => 100
  
  def todays?
    self.created_at.to_date == Date.today
  end    
end
