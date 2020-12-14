class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:create, :destroy]

  def index
    @likes = current_user.likes.includes(:post).order(id: "DESC").paginate(page: params[:page])
  end

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    @user = @post.user
    @group = @post.group
    if @like.save
      respond_to :js
    else
      flash[:alert] = "likeに失敗しました"
    end
    if @user != current_user
      @user.notifications.create(post_id: @post.id, action_type: :liked_to_post,
                                 from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    @group = @post.group
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = "likeの削除に失敗しました"
    end
  end

  private

  def like_params
    params.permit(:post_id)
  end
end
