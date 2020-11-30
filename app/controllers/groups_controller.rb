class GroupsController < ApplicationController
  before_action :set_group, only: [:destroy, :edit, :update]
  before_action :authenticate_user!
  before_action :admin_user!, only: [:destroy, :edit, :update]

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "グループを作成しました"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    if current_user == @group.admin_user
      @group.destroy
      flash[:notice] = "グループを削除しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループを更新しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :admin_user_id, user_ids: [] )
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def admin_user?
    @group = Group.find(params[:id])
    current_user == @group.admin_user
  end

  def admin_user!
    @group = Group.find(params[:id])
    if !admin_user?
      flash[:alert] = "あなたはグループ管理者ではありません"
      redirect_to(root_url)
    end
  end
end
