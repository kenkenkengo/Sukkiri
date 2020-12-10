RSpec.describe "グループ新規登録", type: :system do
  let(:user) { create(:user, :user_with_groups) }

  context "グループ新規登録ページ" do
    before do
      login_as(user)
      visit new_group_path
    end

    it "「グループ新規登録」の文字列が存在することを確認" do
      expect(page).to have_content 'グループ新規登録'
    end

    context "新規登録が成功する時" do
      let!(:other_user) { create(:user) }

      it "有効なグループの作成成功フラッシュ表示" do
        fill_in "グループ名", with: "example group"
        click_button "登録する"
        expect(page).to have_content "グループを作成しました"
      end

      it "チェックボックスでチェックをつけられたユーザーのみグループに入室許可を与える" do
        visit new_group_path
        fill_in "グループ名", with: "example group"
        check other_user.username
        expect(page).to have_checked_field(other_user.username)
        click_button "登録する"
        visit user_path(other_user)
        within ".user_belonging" do
          expect(page).to have_link "example group", href: group_posts_path(user.groups.second)
        end
      end
    end

    context "新規登録が失敗する時" do
      it "グループ名が空の場合の作成失敗表示" do
        fill_in "グループ名", with: ""
        click_button "登録する"
        expect(page).to have_content "グループ名を入力してください"
      end

      it "既に存在するグループ名でグループ作成する場合の失敗表示" do
        group = user.groups.first
        fill_in "グループ名", with: group.name
        click_button "登録する"
        expect(page).to have_content "グループ名はすでに存在します"
      end
    end
  end

  context "グループ一覧ページ" do
    before do
      login_as(user)
      @groups = create_list(:group, 6, admin_user_id: user.id)
      @groups.each do |g|
        create(:belonging, user: user, group: g)
      end
      visit groups_path
    end

    it "グループ管理者名とグループ名が表示されること" do
      expect(page).to have_link user.username, href: user_path(user)
      expect(page).to have_link @groups.first.name, href: group_posts_path(@groups.first)
    end

    it "ぺージネーションが表示されること" do
      expect(page).to have_css "div.pagination"
    end
  end
end
