RSpec.describe "Sessions", type: :system do
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  describe "サインインページ" do
    context "ページレイアウト" do
      it "「サインインフォーム」の文字列が存在する" do
        expect(page).to have_content 'サインインフォーム'
      end

      it "サインインフォームが正しく表示される" do
        expect(page).to have_css 'input#user_email'
        expect(page).to have_css 'input#user_password'
      end

      it "サインインボタンが表示される" do
        expect(page).to have_button 'サインインする'
      end

      it "アカウント登録ページへのリンクが存在する" do
        expect(page).to have_link '登録する', href: new_user_registration_path
      end
    end

    context "サインイン処理" do
      it "無効なユーザーでサインインを行うとサインインが失敗する" do
        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "pass"
        click_button "サインインする"
        expect(page).to have_content 'メールアドレスまたはパスワードが違います'
      end

      it "有効なユーザーでログインするとヘッダーが正しく表示される" do
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path

        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_button "サインイン"

        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end
    end
  end
end
