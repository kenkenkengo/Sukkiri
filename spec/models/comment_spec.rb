RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:temp_group) { create(:group, admin_user_id: user.id) }
  let(:post) { create(:post, :image, user: user, group: temp_group) }

  context "バリデーション" do
    it "commentが有効であること" do
      comment = build(:comment, comment: "hello world!", user: user, post: post)
      expect(comment).to be_valid
    end

    it "コメント内容がnilの場合、commentが無効であること" do
      comment = build(:comment, comment: nil, user: user, post: post)
      expect(comment).to be_invalid
    end

    it "user_idがnilの場合、commentが無効であること" do
      comment = build(:comment, comment: "hello world!", user: nil, post: post)
      expect(comment).to be_invalid
    end

    it "post_idがnilの場合、commentが無効であること" do
      comment = build(:comment, comment: "hello world!", user: user, post: nil)
      expect(comment).to be_invalid
    end
  end
end
