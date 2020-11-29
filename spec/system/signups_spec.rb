RSpec.describe "Signups", type: :system do
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

    it "無効なユーザーの登録失敗表示" do
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
