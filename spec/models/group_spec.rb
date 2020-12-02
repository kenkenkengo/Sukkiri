RSpec.describe Group, type: :model do
  let(:group) { create(:group) }

  context "バリデーション" do
    it "グループネーム、admin_user_idが存在すれば有効である" do
      expect(group).to be_valid
    end

    it "グループネームがなければ無効な状態である" do
      group = build(:group, name: nil)
      group.valid?
      expect(group.errors[:name]).to include("を入力してください")
    end

    it "グループネームが20文字以内である" do
      group = build(:group, name: "a" * 21)
      group.valid?
      expect(group.errors[:name]).to include("は20文字以内で入力してください")
    end

    it "管理者IDがなければ無効な状態である" do
      group = build(:group, admin_user_id: nil)
      group.valid?
      expect(group.errors[:admin_user_id]).to include("を入力してください")
    end

    it "重複したグループネームなら無効な状態である" do
      other_group = build(:group, name: group.name)
      other_group.valid?
      expect(other_group.errors[:name]).to include("はすでに存在します")
    end
  end
end
