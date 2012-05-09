class Task < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :description
  validates_length_of :description, :maximum => 140
  
  def touched?
    self.updated_at.to_date == Date.today
  end
  def old?
    self.created_at.to_date != Date.today
  end
  def weeks?
    self.updated_at < Date.today.end_of_week && self.updated_at > Date.today.beginning_of_week
  end
  def months?
    self.updated_at < Date.today.end_of_month && self.updated_at > Date.today.beginning_of_month
  end  
  def last_weeks?
    self.updated_at < Date.today.prev_week.end_of_week && self.updated_at > Date.today.prev_week.beginning_of_week
  end     
  def last_months?
    self.updated_at < (Date.today-1.month).end_of_month && self.updated_at > (Date.today-1.month).beginning_of_month
  end   
  def self.types
    [
      "Development",
      "Testing",
      "Troubleshooting",
      "Maintenance/Administration",
      "Packaging",
      "Discussions/Meeting",
      "Documentation",
      "Research/Study",
      "Others"
    ]
  end
  
  def to_s
    if self.task_type
      self.task_type + ": " + self.description
    else
      self.description
    end
  end
end
