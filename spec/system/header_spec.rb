RSpec.describe "Header", type: :system do
  let!(:user) { create(:user) }

  describe "ヘッダー表示" do
    context "サインインしている時はヘッダーが存在する" do
      before do
        login_as(user)
      end

      it "ユーザープロフィールページ" do
        visit user_path(user)
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "ユーザー編集ページ" do
        visit edit_user_registration_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "パスワード変更ページ" do
        visit edit_password_path(user)
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "Sukkiriについてページ" do
        visit about_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "利用規約ページ" do
        visit terms_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end
    end

    context "サインインしていない時はヘッダーが存在しない" do
      it "トップページ" do
        visit root_path
        expect(page).not_to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "サインアップページ" do
        visit new_user_registration_path
        expect(page).not_to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "サインインページ" do
        visit new_user_session_path
        expect(page).not_to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end
    end
  end
end
