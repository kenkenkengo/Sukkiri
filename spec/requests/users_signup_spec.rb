RSpec.describe "新規登録", type: :request do
  it "httpリクエストは成功する" do
    get new_user_registration_path
    expect(response).to have_http_status(:success)
  end
end
