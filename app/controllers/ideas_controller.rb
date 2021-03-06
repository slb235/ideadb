class IdeasController < ApplicationController
  before_filter :correct_user
  
  def index
    @project = Project.find_by_id(params[:project_id])
    @ideas = @project.ideas.all :order => :id
    @pu = ProjectUser.where(:user_id => current_user, :project_id => @project)
    db_activity = Activity.where(:project_id => @project.id).order('created_at DESC').limit(75)
    @activity = []
    prev_act = nil

    db_activity.each do |act|
      if prev_act
        if act.user == prev_act.user and act.idea == prev_act.idea and act.action == prev_act.action
        else
          @activity.push prev_act
          prev_act = act
        end
      else
        prev_act = act
      end
    end

    @activity.push prev_act unless prev_act.nil?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ideas }
    end
  end

  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @idea }
    end
  end

  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @idea }
    end
  end


  def edit
    @idea = Idea.find(params[:id])
  end


  def create
    @idea = Idea.new(:title => params[:idea][:title],
                     :project_id => params[:project_id])
    @idea.user = current_user
    get_tags params

    respond_to do |format|
      if @idea.save
        Activity.create! :user => current_user, :project => @idea.project, :idea => @idea, :action => 'created'
        format.html { redirect_to project_idea_path(@idea.project, @idea), :notice => 'Idea was successfully created.' }
        format.json { render :json => @idea, :status => :created, :location => project_idea_path(@idea.project, @idea) }
      else
        format.html { render :action => "new" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @idea = Idea.find(params[:id])
    Activity.create! :user => current_user, :project => @idea.project, :idea => @idea, :action => 'modified'

    respond_to do |format|
      @idea.title = params[:idea][:title]
      get_tags params
      if @idea.save
        format.html { redirect_to project_idea_path(@idea.project, @idea), :notice => 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @project = @idea.project
    Activity.create! :user => current_user, :project => @idea.project, :idea => @idea, :action => 'destroyed'
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to project_ideas_path(@project) }
      format.json { head :no_content }
    end
  end


  private
    def get_tags(params)
      tag_list = ""
      if params[:idea][:tags]
        params[:idea][:tags].each do |t|
          tag_list += t[:name]  + ","
        end
      end
      @idea.tag_list = tag_list      
    end

    def correct_user
      @project = Project.find_by_id(params[:project_id])
      unless @project.users.include? current_user
        flash[:warning] = "This is not ur project"
        redirect_to dashboard_path
      end 
    end    
end
