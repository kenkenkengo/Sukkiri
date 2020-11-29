RSpec.describe "Header", type: :system do
  let!(:user) { create(:user) }
  let(:group) { create(:group, admin_user_id: user.id) }

  describe "ヘッダー表示" do
    context "サインインしている時" do
      before do
        login_as(user)
      end

      it "トップページ" do
        visit root_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "ユーザープロフィールページ" do
        visit user_path(user)
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "ユーザー編集ページ" do
        visit edit_user_registration_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "ユーザー一覧ページ" do
        visit users_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "パスワード変更ページ" do
        visit edit_password_path(user)
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "Sukkiriについてページ" do
        visit about_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "利用規約ページ" do
        visit terms_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "グループ詳細ページ" do
        visit group_path(group)
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "グループ新規作成ページ" do
        visit new_group_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "グループ編集ページ" do
        visit edit_group_path(group)
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).to have_link 'ユーザー一覧', href: users_path
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link 'サインアウト', href: destroy_user_session_path
      end
    end

    context "サインインしていない時" do
      it "トップページ" do
        visit root_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "サインアップページ" do
        visit new_user_registration_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link 'ユーザー一覧', href: users_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "サインインページ" do
        visit new_user_session_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link 'ユーザー一覧', href: users_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "Sukkiriについてページ" do
        visit about_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link 'ユーザー一覧', href: users_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end

      it "利用規約ページ" do
        visit terms_path
        expect(page).to have_link 'Sukkiri', href: root_path
        expect(page).not_to have_link 'ユーザー一覧', href: users_path
        expect(page).not_to have_link '', href: user_path(user)
        expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
      end
    end
  end
end
