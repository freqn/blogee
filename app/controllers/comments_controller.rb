class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to @post
      Notifier.comment_updated(@comment, @post.user).deliver
      flash[:notice] = "Comment has been saved."

    else
      flash[:alert] = "Comment has not been saved."
      render "new"
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment has been updated."
      redirect_to post_path(@post)
    else
      flash[:error] = "Comment has not been updated."
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:author, :content)
  end
end
