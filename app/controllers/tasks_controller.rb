class TasksController < ApplicationController
  # GET /tasks
  def index
    @users = User.sorted
  end
  
  # GET /tasks/today
  def today
    @body = User.today_text
  end
  
  def month
    @users = User.sorted
  end

  # GET /tasks/all
  def all
    @users = User.sorted
  end

  # GET /tasks/week
  def week
    @users = User.sorted
    respond_to do |format|
      format.html
      format.json
    end

  end

  # GET /tasks/new
  def new
    @task = Task.new
    if params[:user_id]
      @task.user = User.find(params[:user_id])
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end
  
  # GET /tasks/1/done
  def done
    @task = Task.find(params[:id])
    @task.update_attributes(:status => true)
    redirect_to(tasks_path + "##{@task.user.username}", :notice => 'Task marked as done.')
  end

  # GET /tasks/1/continue
  def continue
    @task = Task.find(params[:id])
    if @task.status
      @task.update_attributes(:status => false)
      if !@task.old?
        @task.update_attributes(:created_at => Time.now - 1.day)
      end
    else
      @task.touch
    end
    redirect_to(tasks_path + "##{@task.user.username}", :notice => 'Task marked in progress.')
  end

  # GET /tasks/1/willdo
"""
  def willdo
    @task = Task.find(params[:id])
    @task.touch(:created_at)
    redirect_to(tasks_path, :notice => 'Task marked to be done.')
  end
"""

  # POST /tasks
  def create
    @task = Task.new(params[:task])

    if @task.save
      redirect_to(tasks_path + "##{@task.user.username}", :notice => 'Task was successfully created.')
    else
      @users = User.sorted    
      render :action => "index"
    end
  end

  # PUT /tasks/1
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to(tasks_path + "##{@task.user.username}", :notice => 'Task was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to(tasks_url + "##{@task.user.username}", :notice => 'Task was successfully deleted.')
  end

  # POST /tasks/email
  def email
    Report.today(params[:body]).deliver
    redirect_to(tasks_url, :notice => 'Email sent to swcert-internal@redhat.com.')
  end
end
