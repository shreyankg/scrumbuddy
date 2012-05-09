task :scrum, :needs => :environment do
  Report.today.deliver
end

task :weekly, :needs => :environment do
  Report.last_week.deliver
end

task :monthly, :needs => :environment do
  Report.last_month.deliver
end

