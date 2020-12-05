RSpec.describe Post, type: :model do
  let(:user) { build(:user) }
  let(:temp_group) { build(:group, admin_user_id: user.id) }

  context "バリデーション" do
    it "user_id, group_id, imageが存在すれば有効である" do
      post = build(:post, :image, user: user, group: temp_group)
      expect(post).to be_valid
    end

    it "user_idがなければ無効である" do
      post = build(:post, :image, user: nil, group: temp_group)
      expect(post).to be_invalid
    end

    it "group_idがなければ無効である" do
      post = build(:post, :image, user: user, group: nil)
      expect(post).to be_invalid
    end

    it "imageがなければ無効である" do
      post = build(:post, image: nil, user: user, group: temp_group)
      expect(post).to be_invalid
    end
  end
end
