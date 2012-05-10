class Report < ActionMailer::Base
  default :from => ScrumConfig::FROM

  def today
    @text = User.today_text 
    mail(:to => ScrumConfig::MAILING_LIST,
         :subject => "Scrum updates for #{l Date.today, :format => :long}")
  end

  def last_week
    @text = User.last_week_text 
    mail(:to => ScrumConfig::MAILING_LIST,
         :subject => "Scrum summary for week ending #{ Date.today.prev_week + 4.days}")
  end  

  def last_month
    @text = User.last_month_text 
    mail(:to => ScrumConfig::MAILING_LIST,
         :subject => "Scrum summary for Month of #{ Date.today.prev_month.strftime("%B %Y")}")
  end  
end
