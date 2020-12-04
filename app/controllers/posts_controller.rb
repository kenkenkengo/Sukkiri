class PostsController < ApplicationController
  before_action :set_group
  before_action :set_post, only: [:show, :destroy, :edit, :update]
  before_action :authenticate_user!
  before_action :correct_user
  before_action :post_user, only: [:destroy, :edit, :update]

  def index
    @post = Post.new
    @posts = @group.posts.includes(:user).order(id: "DESC")
  end

  def show
  end

  def create
    @post = @group.posts.new(post_params)
    if @post.save
      flash[:notice] = "写真を投稿しました"
      redirect_to group_posts_path(@group)
    else
      @posts = @group.posts.includes(:user)
      flash.now[:alert] = '写真の選択をしてください'
      render :index
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to group_posts_path(@group)
    else
      flash.now[:alert] = '許可されていません'
      render :edit
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to group_posts_path(@group)
    else
      flash.now[:alert] = '入力値が不正です'
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = @group.posts.find_by(id: params[:id])
  end

  def correct_user
    unless current_user.groups.find_by(id: params[:group_id])
      redirect_to user_path(current_user)
      flash[:alert] = "入室許可されたグループではありません"
    end
  end

  def post_user
    unless current_user.posts.find_by(id: params[:id])
      redirect_to user_path(current_user)
      flash[:alert] = "あなたの投稿ではないため許可されていません"
    end
  end
end
