RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: "other@example.com") }

  describe "新規登録ページ" do
    before do
      visit new_user_registration_path
    end

    it "「新規登録」の文字列が存在する" do
      expect(page).to have_content '新規登録'
    end

    it "有効なユーザーの登録成功フラッシュ表示" do
      fill_in "ユーザーネーム", with: "Example User"
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワードの確認", with: "password"
      click_button "登録する"
      expect(page).to have_content "アカウント登録が完了しました"
    end

    it "無効なユーザーの登録失敗フラッシュ表示" do
      fill_in "ユーザーネーム", with: ""
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワードの確認", with: "foobar"
      click_button "登録する"
      expect(page).to have_content "ユーザーネームを入力してください"
      expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
    end
  end

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
      expect(page).to have_content user.email
    end

    context "サインインユーザーのユーザープロフィールを表示する時" do
      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'プロフィールを編集', href: edit_user_registration_path
      end
    end

    context "サインインユーザーでないユーザープロフィールを表示する時" do
      it "プロフィール編集ページへのリンクが表示されていないことを確認" do
        logout(:user)
        login_as(other_user)
        visit user_path(user)
        expect(page).not_to have_link 'プロフィールを編集', href: edit_user_registration_path
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
end
