class CommentsController < ApplicationController

  def new
  end

  def create
    @commentable = extract_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created successfully"
    else
      flash[:success] = "Failed to create comment"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @commentable = extract_commentable
    @comment = @commentable.comments.find(params[:id])
    if @comment.delete
      flash[:success] = "Comment deleted successfully"
    else
      flash[:danger] = "Failed to delete comment"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def extract_commentable
    model = params[:commentable].classify.constantize
    id_key = (params[:commentable].downcase + "_id").to_sym
    model.find(params[id_key])
  end

end
