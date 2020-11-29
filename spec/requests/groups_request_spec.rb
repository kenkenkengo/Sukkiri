RSpec.describe "グループ新規登録", type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group, admin_user_id: user.id) }
  let!(:other_group) { create(:group, admin_user_id: user.id) }

  before do
    login_as(user)
    get new_group_path
  end

  it "httpリクエストは成功する" do
    expect(response).to have_http_status "200"
  end

  context 'パラメータが妥当な場合' do
    it 'グループ登録が成功すること' do
      expect do
        post groups_path, params: { group: group.name }
      end.to change(Group, :count).by(1)
    end
  end

  context 'パラメータが不正な場合' do
    it 'グループ名が空であればグループ登録が失敗すること' do
      expect do
        post groups_path, params: { group: "" }
      end.not_to change(Group, :count)
    end

    it 'グループ名が既に存在すればグループ登録が失敗すること' do
      expect do
        post groups_path, params: { group: { name: other_group.name } }
      end.not_to change(Group, :count)
    end
  end
end
