class BlockersController < ApplicationController

  # GET /blockers/new  
  def new
    @blocker = Blocker.new
    if params[:user_id]
      @blocker.user = User.find(params[:user_id])
    end  
  end

  # GET /blockers/1/edit
  def edit
    @blocker = Blocker.find(params[:id])
  end
  

  # POST /blockers
  def create
    @blocker = Blocker.new(params[:blocker])

    if @blocker.save
      redirect_to(tasks_path + "##{@blocker.user.username}", :notice => 'Blocker was successfully added.')
    else
      @users = User.sorted
      render "tasks/index"
    end  
  end

  # PUT /blockers/1
  def update
    @blocker = Blocker.find(params[:id])
    if @blocker.update_attributes(params[:blocker])
      redirect_to(tasks_path + "##{@blocker.user.username}", :notice => 'Blocker was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /blockers/1
  def destroy
    @blocker = Blocker.find(params[:id])
    @blocker.destroy
    redirect_to(tasks_url + "##{@blocker.user.username}", :notice => 'Blocker was successfully deleted.')
  end

end
