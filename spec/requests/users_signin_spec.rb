RSpec.describe "サインイン", type: :request do
  it "httpリクエストは成功する" do
    get new_user_session_path
    expect(response).to have_http_status(:success)
  end
end
