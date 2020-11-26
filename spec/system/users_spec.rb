RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }

  describe "新規登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "ページレイアウト" do
      it "「新規登録」の文字列が存在する" do
        expect(page).to have_content '新規登録'
      end
    end

    context "新規登録処理" do
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
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        visit user_path(user)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
      end
    end
  end
end
