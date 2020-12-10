RSpec.describe "グループ編集", type: :system do
  let!(:user) { create(:user, :user_with_groups) }
  let!(:other_user) { create(:user) }

  context "ユーザーがグループ管理者の場合" do
    before do
      login_as(user)
      @group = user.groups.first
      visit edit_group_path(@group)
    end

    it "「グループ編集」の文字列が存在することを確認" do
      expect(page).to have_content 'グループ編集'
    end

    context "グループ編集が成功する時" do
      it "グループの編集成功フラッシュ表示" do
        fill_in "グループ名", with: "example group"
        check other_user.username
        expect(page).to have_checked_field(other_user.username)
        click_button "更新する"
        expect(page).to have_content "グループを更新しました"
        within ".user_belonging" do
          expect(page).to have_link "example group", href: group_posts_path(@group)
        end
        visit user_path(other_user)
        within ".user_belonging" do
          expect(page).to have_link "example group", href: group_posts_path(@group)
        end
      end
    end
  end

  context "グループ編集が失敗する時" do
    before do
      login_as(user)
      @group = user.groups.first
      visit edit_group_path(@group)
    end

    it "グループ名が空の場合の編集失敗表示" do
      fill_in "グループ名", with: ""
      click_button "更新する"
      expect(page).to have_content "グループ名を入力してください"
    end
  end

  context "ユーザーがグループ管理者でない場合" do
    let(:user2) { create(:user) }

    before do
      login_as(user2)
    end

    it "ユーザーは自分がグループ管理者でないグループを編集できない" do
      group = user.groups.first
      visit edit_group_path(group)
      expect(page).to have_content "あなたはグループ管理者ではありません"
    end
  end
end
