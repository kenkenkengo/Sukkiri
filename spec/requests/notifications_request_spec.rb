RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }

  context "通知一覧ページの表示" do
    context "ログインユーザーの場合" do
      before do
        login_as(user)
      end

      it "レスポンスが正常に表示されること" do
        get notifications_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページへリダイレクトすること" do
        get notifications_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
