RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  context "サインインしている時" do
    before do
      login_as(user)
    end

    it "httpリクエストは成功する" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  context "サインインしていない時" do
    it "httpリクエストは失敗する" do
      get user_path(user)
      expect(response).not_to have_http_status(:success)
    end
  end
end
