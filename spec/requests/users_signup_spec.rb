RSpec.describe "新規登録", type: :request do
  let!(:user_params) { attributes_for(:user) }
  let!(:invalid_user_params) { attributes_for(:user, username: "") }

  before do
    get new_user_registration_path
  end

  it "httpリクエストは成功する" do
    expect(response).to have_http_status(:success)
  end

  context 'パラメータが妥当な場合' do
    it 'ユーザー登録が成功すること' do
      expect do
        post user_registration_path, params: { user: user_params }
      end.to change(User, :count).by(1)
    end
  end

  context 'パラメータが不正な場合' do
    it 'ユーザー登録が失敗すること' do
      expect do
        post user_registration_path, params: { user: invalid_user_params }
      end.not_to change(User, :count)
    end
  end
end
