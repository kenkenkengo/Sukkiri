RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context "バリデーション" do
    it "ユーザーネーム、メールアドレスが存在すれば有効である" do
      expect(user).to be_valid
    end

    it "ユーザーネームがなければ無効な状態である" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end

    it "ユーザーネームが20文字以内である" do
      user = build(:user, username: "a" * 21)
      user.valid?
      expect(user.errors[:username]).to include("は20文字以内で入力してください")
    end

    it "メールアドレスがなければ無効な状態である" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "メールアドレスが255文字以内である" do
      user = build(:user, email: "#{"a" * 244}@example.com")
      user.valid?
      expect(user.errors[:email]).to include("は255文字以内で入力してください")
    end

    it "重複したメールアドレスなら無効な状態である" do
      other_user = build(:user, email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスは小文字で保存される" do
      email = "SamPle@example.com"
      user = create(:user, email: email)
      expect(user.email).to eq email.downcase
    end

    it "パスワードがなければ無効な状態である" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードとパスワード確認が一致しなければ無効である" do
      user = build(:user, password_confirmation: 'hogehoge')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "パスワードが6文字以上である" do
      user = build(:user, password: "a" * 6, password_confirmation: "a" * 6)
      user.valid?
      expect(user).to be_valid
    end
  end
end
