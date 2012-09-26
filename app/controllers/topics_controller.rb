class TopicsController < ApplicationController
  load_and_authorize_resource

  # GET /boards/:board_id/topics
  # GET /boards/:board_id/topics.json
  def index
    @board  = Board.find(params[:board_id])
    @topics = @board.topics

    respond_to do |format|
      format.html { redirect_to board_path(@board) }
      format.json { render :json => @topics }
    end
  end

  # GET /boards/:board_id/topics/1
  # GET /boards/:board_id/topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @title = @topic.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @topic }
    end
  end

  # GET /boards/:board_id/topics/new
  # GET /boards/:board_id/topics/new.json
  def new
    @board   = Board.find(params[:board_id])
    @topic   = Topic.new
    @comment = @topic.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /boards/:board_id/topics/1/edit
  def edit
    @topic   = Topic.find(params[:id])
    @title   = @topic.name
    @board   = @topic.board
    @comment = @topic.comments.first
  end

  # POST /boards/:board_id/topics
  # POST /boards/:board_id/topics.json
  def create
    @board   = Board.find(params[:board_id])
    @topic   = Topic.new(params[:topic])
    @comment = @topic.comments.build(params[:comment])

    @topic.board_id  = @board.id
    @topic.author_id = @comment.author_id = current_user.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to board_path(@board),
                      :notice => 'Topic was successfully created.' }
        format.json { render :json => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/:board_id/topics/1
  # PUT /boards/:board_id/topics/1.json
  def update
    @topic   = Topic.find(params[:id])
    @comment = @topic.comments.first

    respond_to do |format|
      if @topic.update_attributes(params[:topic]) and
         @comment.update_attributes(params[:comment])
        format.html { redirect_to board_topic_path(:board_id => @topic.board, :id => @topic),
                      :notice => 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/:board_id/topics/1
  # DELETE /boards/:board_id/topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to board_path(@topic.board) }
      format.json { head :no_content }
    end
  end
end