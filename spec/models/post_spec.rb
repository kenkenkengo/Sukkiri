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

  context "liked_by(user)メソッド" do
    let(:user) { create(:user, :user_with_groups_and_posts_and_likes) }

    before do
      @post = user.posts.first
      @like = user.likes.first
    end

    it "post, userに紐づいたlikeインスタンスを返す" do
      expect(@post.liked_by(user)).to eq @like
    end
  end
end
