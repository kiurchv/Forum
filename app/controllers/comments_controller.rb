class CommentsController < ApplicationController
  load_and_authorize_resource
  
  # GET /boards/:board_id/topics/:topic_id/comments
  # GET /boards/:board_id/topics/:topic_id/comments.json
  def index
    @topic    = Topic.find(params[:topic_id])
    @comments = @topic.comments

    respond_to do |format|
      format.html { redirect_to board_topic_path(:board_id => @topic.board, :id => @topic) }
      format.json { render json: @comments }
    end
  end

  # GET /boards/:board_id/topics/:topic_id/comments/1
  # GET /boards/:board_id/topics/:topic_id/comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html { redirect_to board_topic_comment_path(@comment) }
      format.json { render :json => @comment }
    end
  end

  # GET /boards/:board_id/topics/:topic_id/comments/new
  # GET /boards/:board_id/topics/:topic_id/comments/new.json
  def new
    @topic   = Topic.find(params[:topic_id])
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @comment }
    end
  end

  # GET /boards/:board_id/topics/:topic_id/comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @topic   = @comment.topic
  end

  # POST /boards/:board_id/topics/:topic_id/comments
  # POST /boards/:board_id/topics/:topic_id/comments.json
  def create
    @topic   = Topic.find(params[:topic_id])
    @comment = Comment.new(params[:comment])
    
    @comment.topic_id  = @topic.id
    @comment.author_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to board_topic_comment_path(@comment),
                      :notice => 'Comment was successfully created.' }
        format.json { render json: @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/:board_id/topics/:topic_id/comments/1
  # PUT /boards/:board_id/topics/:topic_id/comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to board_topic_comment_path(@comment),
                      :notice => 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/:board_id/topics/:topic_id/comments/1
  # DELETE /boards/:board_id/topics/:topic_id/comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to board_topic_path(:board_id => @comment.topic.board, :id => @comment.topic) }
      format.json { head :no_content }
    end
  end

  private

  def board_topic_comment_path(comment)
    "#{board_topic_path(:board_id => comment.topic.board, :id => comment.topic)}/#comment_#{comment.id}"
  end
end