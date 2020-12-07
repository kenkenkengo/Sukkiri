RSpec.describe Belonging, type: :model do
  let(:user) { create(:user) }
  let(:group) { create(:group, admin_user_id: user.id) }

  context "バリデーション" do
    it "belongingが有効であること" do
      belonging = build(:belonging, user: user, group: group)
      expect(belonging).to be_valid
    end

    it "user_idがnilの場合、belongingが無効であること" do
      belonging = build(:belonging, user: nil, group: group)
      expect(belonging).to be_invalid
    end

    it "group_idがnilの場合、belongingが無効であること" do
      belonging = build(:belonging, user: user, group: nil)
      expect(belonging).to be_invalid
    end
  end
end
