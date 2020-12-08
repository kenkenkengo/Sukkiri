RSpec.describe Notification, type: :model do
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
