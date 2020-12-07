RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:temp_group) { create(:group, admin_user_id: user.id) }
  let(:post) { create(:post, :image, user: user, group: temp_group) }

  context "バリデーション" do
    it "likeが有効であること" do
      like = build(:like, user: user, post: post)
      expect(like).to be_valid
    end

    it "user_idがnilの場合、likeが無効であること" do
      like = build(:like, user: nil, post: post)
      expect(like).to be_invalid
    end

    it "post_idがnilの場合、likeが無効であること" do
      like = build(:like, user: user, post: nil)
      expect(like).to be_invalid
    end
  end
end
