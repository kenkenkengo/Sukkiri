class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @likes = current_user.likes.includes(:user).order(id: "DESC")
  end

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    @group = @post.group
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    @group = @post.group
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
    end
end
