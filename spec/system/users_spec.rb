RSpec.describe "Users", type: :system do
  let(:user) { create(:user, :user_with_groups) }

  describe "プロフィールページ" do
    before do
      login_as(user)
      visit user_path(user)
    end

    it "「プロフィール」の文字列が存在することを確認" do
      expect(page).to have_content 'プロフィール'
    end

    it "ユーザー情報が表示されることを確認" do
      expect(page).to have_content user.username
    end

    context "サインインユーザーのユーザープロフィールを表示する時" do
      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'プロフィールを編集', href: edit_user_registration_path
      end

      it "グループ新規作成ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'グループ新規作成', href: new_group_path
      end

      it "プロフィールユーザーが入室できるグループへのリンクが表示されていることを確認" do
        group = user.groups.first
        within ".user_belonging" do
          expect(page).to have_link group.name, href: group_posts_path(group)
        end
      end
    end

    context "サインインユーザーでないユーザープロフィールを表示する時" do
      let(:other_user) { create(:user, :user_with_groups) }

      before do
        @group = other_user.groups.first
        @group2 = create(:group, admin_user_id: other_user.id)
        create(:belonging, user: user, group: @group2)
        create(:belonging, user: other_user, group: @group2)
        visit user_path(other_user)
      end

      it "プロフィール編集ページへのリンクが表示されていないことを確認" do
        expect(page).not_to have_link 'プロフィールを編集', href: edit_user_registration_path
      end

      it "プロフィールユーザーが入室できるグループへのリンクが表示されていることを確認" do
        within ".user_belonging" do
          expect(page).to have_link @group.name, href: group_posts_path(@group)
          expect(page).to have_link @group2.name, href: group_posts_path(@group2)
        end
      end

      it "サインインユーザーが入室できるグループへのリンクのみ表示されていることを確認" do
        within ".current_user_belonging" do
          expect(page).not_to have_link @group.name, href: group_posts_path(@group)
          expect(page).to have_link @group2.name, href: group_posts_path(@group2)
        end
      end
    end
  end

  describe "プロフィール編集ページ" do
    before do
      login_as(user)
      visit edit_user_registration_path(user)
    end

    it "「プロフィール編集」の文字列が存在することを確認" do
      expect(page).to have_content 'プロフィール編集'
    end

    it "「パスワード変更」「アカウント削除」のリンクが存在する" do
      expect(page).to have_link 'パスワード変更', href: edit_password_path(user)
      expect(page).to have_link 'アカウント削除', href: user_registration_path
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示される" do
      fill_in "ユーザーネーム", with: "Example User2"
      fill_in "メールアドレス", with: "user2@example.com"
      click_button "変更する"
      expect(page).to have_content "アカウント情報を変更しました。"
      expect(user.reload.username).to eq "Example User2"
      expect(user.reload.email).to eq "user2@example.com"
    end

    it "無効なプロフィール更新であれば、エラーメッセージが表示される" do
      fill_in "ユーザーネーム", with: ""
      fill_in "メールアドレス", with: ""
      click_button "変更する"
      expect(page).to have_content 'ユーザーネームを入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
    end
  end

  describe "パスワード編集ページ" do
    before do
      login_as(user)
      visit edit_password_path(user)
    end

    it "「パスワード編集」の文字列が存在することを確認" do
      expect(page).to have_content 'パスワード編集'
    end

    it "有効なパスワード更新を行うと、更新成功のフラッシュが表示される" do
      fill_in "現在のパスワード", with: "foobar"
      fill_in "パスワード", with: "foobar2"
      fill_in "パスワードの確認", with: "foobar2"
      click_button "変更する"
      expect(page).to have_content "パスワード変更しました"
    end

    it "現在のパスワードが間違っていると、エラーメッセージが表示される" do
      fill_in "現在のパスワード", with: ""
      fill_in "パスワード", with: "foobar2"
      fill_in "パスワードの確認", with: "foobar2"
      click_button "変更する"
      expect(page).to have_content '現在のパスワードが間違っています'
    end

    it "パスワードとパスワード確認が正しく入力されていないと、エラーメッセージが表示される" do
      fill_in "現在のパスワード", with: "foobar"
      fill_in "パスワード", with: "foobar2"
      fill_in "パスワードの確認", with: "foobar3"
      click_button "変更する"
      expect(page).to have_content 'パスワードを正しく入力してください'
    end

    it "「プロフィール編集へ戻る」のリンクが存在する" do
      expect(page).to have_link 'プロフィール編集へ戻る', href: edit_user_registration_path
    end
  end

  describe "ユーザー一覧ページ" do
    it "ぺージネーションが表示されること" do
      create_list(:user, 31)
      login_as(user)
      visit users_path
      expect(page).to have_css "div.pagination"
      User.paginate(page: 1).each do |u|
        expect(page).to have_link u.username, href: user_path(u)
      end
    end
  end
end
