RSpec.describe "プロフィール編集", type: :request do
  let!(:user_params) { attributes_for(:user, password: nil, password_confirmation: nil) }
  let!(:user) { create(:user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_as(user)
      get edit_user_registration_path(user)
      expect(response).to have_http_status "200"
    end
  end

  context "ログインしていないユーザーの場合" do
    it "編集の時認証エラーが出ること" do
      get edit_user_registration_path(user)
      expect(response).to have_http_status "401"
    end

    it "更新の時認証エラーが出ること" do
      patch user_registration_path(user), params: { user: user_params }
      expect(response).to have_http_status "401"
    end
  end
end
