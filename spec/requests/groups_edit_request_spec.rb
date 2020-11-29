RSpec.describe "グループ編集", type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group, admin_user_id: user.id) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_as(user)
      get edit_group_path(group)
      expect(response).to have_http_status "200"
    end
  end

  context "ログインしていないユーザーの場合" do
    it "編集ページへ遷移せずサインインページへリダイレクトする" do
      get edit_group_path(group)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end

    it "更新は失敗しサインインページへリダイレクトする" do
      patch group_path(group), params: { group: group.name }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end
end
