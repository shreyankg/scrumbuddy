class User < ActiveRecord::Base
  has_many :tasks
  has_many :blockers
  
  def self.sorted
    self.where(:active => true).sort {|a, b| a.name <=> b.name}
  end
  
  def self.sorted_all
    self.all.sort {|a, b| a.name <=> b.name}
  end
  
  def working
    self.tasks.collect {|task| task if (!task.status || task.touched?)}.compact
  end
  def done
    self.tasks.collect {|task| task if task.status}.compact
  end
    
  def touched
    self.tasks.collect {|task| task if task.touched?}.compact
  end

  def last_weeks
    self.tasks.collect {|task| task if task.last_weeks?}.compact    
  end
  
  def last_months
    self.tasks.collect {|task| task if task.last_months?}.compact    
  end
  
  def todays_blockers
    self.blockers.collect {|blocker| blocker if blocker.todays?}.compact
  end
  
  def self.today_text
    main_body = []
    for user in self.sorted
      body = []
      head = user.name + "\n"+ '='*user.name.length
      for task in user.today[:done]
        body << "* #{task} - Done"
      end
      for task in user.today[:continue]
        body << "* #{task}"
      end
      body << ""
      if !(user.today[:start] + user.today[:continue]).empty?
        body << "Working"
        body << "-------"
        for task in user.today[:continue]
          body << "* Continue #{task}"
        end
        for task in user.today[:start]
          body << "* #{task}"
        end
      end
      body << ""
      if !user.todays_blockers.empty?
        body << "Blockers"
        body << "--------"
        for blocker in user.todays_blockers
          body << blocker.description
        end
      end
      body << "" 
      print body
      if body == ["", "", ""]
        body = ["", "No Updates Provided", ""]
      end
      main_body += [head, body]
    end
    return main_body.join("\n")
  end
  
  def self.last_week_text
    main_body = []
    for user in self.sorted
      body = []
      head = user.name + "\n"+ '='*user.name.length
      user.last_week.each do |type, tasks|
        if !tasks.empty?
          body << ""         
          body << type
          body << "-"*type.length
          tasks.each do |task|
            body << task
          end
        end
      end
      body << "" 
      main_body += [head, body]
    end
    return main_body.join("\n")
  end
  
  def self.last_month_text
    main_body = []
    for user in self.sorted
      body = []
      head = user.name + "\n"+ '='*user.name.length
      user.last_month.each do |type, tasks|
        if !tasks.empty?
          body << ""         
          body << type
          body << "-"*type.length
          tasks.each do |task|
            body << task
          end
        end
      end
      body << "" 
      main_body += [head, body]
    end
    return main_body.join("\n")
  end

  def last_week
    out = {}
    Task.types.each do |type|
      out[type] = []
    end
    out["Unspecified"] = []
      for task in self.last_weeks
        if task.task_type
          out[task.task_type] << task.description
        else
          out["Unspecified"] << task.description
        end
      end
    return out
  end
  
        
  def last_month
    out = {}
    Task.types.each do |type|
      out[type] = []
    end
    out["Unspecified"] = []
      for task in self.last_months
        if task.task_type
          out[task.task_type] << task.description
        else
          out["Unspecified"] << task.description
        end
      end
    return out
  end
  
  def today
    out = {
      :done => [],
      :continue => [],
      :start => []
      }
      for task in self.touched
        if task.status
          out[:done] << task.to_s
        else
          if task.old?
            out[:continue] << task.to_s
          else
            out[:start] << task.to_s
          end
        end
      end
      
    return out
  end
    
  def weeks
    self.tasks.collect {|task| task if task.weeks? }.compact
  end
  
  def months
    self.tasks.collect {|task| task if task.months? }.compact
  end
end
