class PostsController < ApplicationController
  before_action :set_group
  before_action :set_post, only: [:show, :destroy, :edit, :update]
  before_action :authenticate_user!
  before_action :correct_user
  before_action :post_user, only: [:destroy, :edit, :update]
  before_action :set_search

  def index
    @post = Post.new
    @posts = @group.posts.includes(:user).order(id: "DESC").paginate(
      page: params[:page], per_page: 5
    )
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

  def set_search
    if user_signed_in?
      @search_word = params[:q][:content_cont] if params[:q]
      @q = @group.posts.paginate(page: params[:page], per_page: 5).ransack(params[:q])
      @search_results = @q.result(distinct: true).order(created_at: "DESC")
    end
  end

  def search
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

  def post_user
    unless current_user.posts.find_by(id: params[:id])
      redirect_to user_path(current_user)
      flash[:alert] = "あなたの投稿ではないため許可されていません"
    end
  end
end
