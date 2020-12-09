RSpec.describe Notification, type: :model do
  context 'バリデーション' do
    it "notificationが有効であること" do
      notification = build(:notification)
      expect(notification).to be_valid
    end

    it "user_idがnilの場合、無効であること" do
      notification = build(:notification, user: nil)
      expect(notification).to be_invalid
    end

    it "post_idがnilの場合、無効であること" do
      notification = build(:notification, post_id: nil)
      expect(notification).to be_invalid
    end

    it "action_typeがnilの場合、無効であること" do
      notification = build(:notification, action_type: nil)
      expect(notification).to be_invalid
    end

    it "from_user_idがnilの場合、無効であること" do
      notification = build(:notification, from_user_id: nil)
      expect(notification).to be_invalid
    end
  end

  context 'active_userメソッド' do
    it 'notificationが存在する場合、likeやコメントを行なったユーザー(from_user_idと同じidを持つユーザー)を返す' do
      notification = build(:notification)
      expect(notification.active_user.id).to eq 2
    end
  end

  context 'activated_postメソッド' do
    it 'notificationが存在する場合、likeやコメントが行われたpostを返す' do
      notification = build(:notification)
      expect(notification.activated_post.id).to eq 1
    end
  end

  context 'activated_groupメソッド' do
    let(:user) { create(:user, :user_with_groups_and_posts) }

    before do
      @post = user.posts.first
      @group = @post.group
    end

    it 'notificationが存在する場合、likeやコメントが行われたpostが属するgroupを返す' do
      notification = build(:notification, post_id: @post.id)
      expect(notification.activated_group).to eq @group
    end
  end
end
