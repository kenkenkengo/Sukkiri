RSpec.describe "グループ編集", type: :request do
  let(:user) { create(:user, :user_with_groups) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_as(user)
      group = user.groups.first
      get edit_group_path(group)
      expect(response).to have_http_status "200"
    end
  end

  context "ログインしていないユーザーの場合" do
    before do
      @group = user.groups.first
    end

    it "編集ページへ遷移せずサインインページへリダイレクトする" do
      get edit_group_path(@group)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end

    it "更新は失敗しサインインページへリダイレクトする" do
      patch group_path(@group), params: { group: { name: @group.name } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end
end
