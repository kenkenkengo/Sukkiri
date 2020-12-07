RSpec.describe "Posts", type: :request do
  let(:user) { create(:user, :user_with_groups_and_posts) }
  let(:temp_group) { attributes_for(:group, admin_user_id: user.id) }
  let(:belonging) { create(:belonging, user: user, group: temp_group) }
  let(:invalid_post_params) { attributes_for(:post, user: user, group: temp_group) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test_image.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  context "グループ入室許可されたユーザーの場合" do
    before do
      login_as(user)
      @group = user.groups.first
      @post = user.posts.first
    end

    it "getリクエストは成功する" do
      get group_posts_path(@group)
      expect(response).to have_http_status "200"
    end

    it "写真が含まれていなければ投稿に失敗すること" do
      expect do
        post group_posts_path(@group), params: { post: invalid_post_params }
      end.not_to change(Post, :count)
    end
  end

  context "グループ入室許可されていないユーザーの場合" do
    let(:other_user) { create(:user) }
    let(:other_post_params) { attributes_for(:post, :image, user: other_user) }

    before do
      login_as(other_user)
      @group = user.groups.first
    end

    it '投稿は失敗すること' do
      expect do
        post group_posts_path(@group), params: { post: other_post_params }
      end.not_to change(Post, :count)
    end
  end
end
