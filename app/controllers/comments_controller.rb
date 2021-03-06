class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    @user = @post.user
    @group = @post.group
    if @comment.save
      respond_to :js
    else
      flash[:alert] = "コメントに失敗しました"
    end
    if @user != current_user
      @user.notifications.create(post_id: @post.id, action_type: :commented_to_post,
                                 from_user_id: current_user.id,
                                 comment: @comment.comment)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @group = @post.group
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :comment)
  end
end
