RSpec.describe "グループ新規登録", type: :request do
  let(:user) { create(:user, :user_with_groups) }
  let!(:group_params) { attributes_for(:group, name: "example") }
  let!(:invalid_group_params) { attributes_for(:group, name: "") }

  describe "認可されたユーザーの場合" do
    before do
      login_as(user)
      get new_group_path
    end

    it "httpリクエストは成功する" do
      expect(response).to have_http_status "200"
    end

    context 'パラメータが不正な場合' do
      it 'グループ名が空であればグループ登録が失敗すること' do
        expect do
          post groups_path, params: { group: invalid_group_params }
        end.not_to change(Group, :count)
      end

      it 'グループ名が既に存在すればグループ登録が失敗すること' do
        group = user.groups.first
        expect do
          post groups_path, params: { group: { name: group.name } }
        end.not_to change(Group, :count)
      end
    end
  end

  describe "ログインしていないユーザーの場合" do
    it "httpリクエストは失敗する" do
      get new_group_path
      expect(response).to have_http_status "302"
    end

    it 'グループ登録が失敗すること' do
      expect do
        post groups_path, params: { group: group_params }
      end.not_to change(Group, :count)
    end
  end
end
