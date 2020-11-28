RSpec.describe "ユーザープロフィール", type: :request do
  let!(:user) { create(:user) }

  context "サインインしている場合" do
    before do
      login_as(user)
    end

    it "プロフィールページへのGETリクエストは成功する" do
      get user_path(user)
      expect(response).to have_http_status "200"
    end
  end

  context "サインインしていない場合" do
    it "サインインページへリダイレクトする" do
      get user_path(user)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end
end
