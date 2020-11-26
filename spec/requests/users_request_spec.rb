RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  it "httpリクエストは成功する" do
    get user_path(user)
    expect(response).to have_http_status(:success)
  end
end
