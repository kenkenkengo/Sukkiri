RSpec.describe "ヘッダー表示", type: :system do
  let(:user) { create(:user, :user_with_groups_and_posts) }

  context "サインインしていない時" do
    it "トップページ" do
      visit root_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).not_to have_link 'group一覧', href: groups_path
      expect(page).not_to have_link 'like一覧', href: likes_path(user)
      expect(page).not_to have_link 'ユーザー一覧', href: users_path
      expect(page).not_to have_link '', href: notifications_path
      expect(page).not_to have_link '', href: user_path(user)
      expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "サインアップページ" do
      visit new_user_registration_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).not_to have_link 'group一覧', href: groups_path
      expect(page).not_to have_link 'like一覧', href: likes_path(user)
      expect(page).not_to have_link 'ユーザー一覧', href: users_path
      expect(page).not_to have_link '', href: notifications_path
      expect(page).not_to have_link '', href: user_path(user)
      expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "サインインページ" do
      visit new_user_session_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).not_to have_link 'group一覧', href: groups_path
      expect(page).not_to have_link 'like一覧', href: likes_path(user)
      expect(page).not_to have_link 'ユーザー一覧', href: users_path
      expect(page).not_to have_link '', href: notifications_path
      expect(page).not_to have_link '', href: user_path(user)
      expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "Sukkiriについてページ" do
      visit about_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).not_to have_link 'group一覧', href: groups_path
      expect(page).not_to have_link 'like一覧', href: likes_path(user)
      expect(page).not_to have_link 'ユーザー一覧', href: users_path
      expect(page).not_to have_link '', href: notifications_path
      expect(page).not_to have_link '', href: user_path(user)
      expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "利用規約ページ" do
      visit terms_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).not_to have_link 'group一覧', href: groups_path
      expect(page).not_to have_link 'like一覧', href: likes_path(user)
      expect(page).not_to have_link 'ユーザー一覧', href: users_path
      expect(page).not_to have_link '', href: notifications_path
      expect(page).not_to have_link '', href: user_path(user)
      expect(page).not_to have_link 'サインアウト', href: destroy_user_session_path
    end
  end

  context "サインインしている時" do
    before do
      login_as(user)
      @group = user.groups.first
      @post = user.posts.first
    end

    it "トップページ" do
      visit root_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "ユーザープロフィールページ" do
      visit user_path(user)
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "ユーザー編集ページ" do
      visit edit_user_registration_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "ユーザー一覧ページ" do
      visit users_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "パスワード変更ページ" do
      visit edit_password_path(user)
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "Sukkiriについてページ" do
      visit about_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "利用規約ページ" do
      visit terms_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "投稿一覧ページ" do
      visit group_posts_path(@group)
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "投稿編集ページ" do
      visit group_posts_path(@group, @post)
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "グループ新規作成ページ" do
      visit new_group_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "グループ編集ページ" do
      visit edit_group_path(@group)
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "like一覧" do
      visit likes_path(user)
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "通知一覧" do
      visit notifications_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end

    it "グループ一覧" do
      visit groups_path
      expect(page).to have_link 'Sukkiri', href: root_path
      expect(page).to have_link 'group一覧', href: groups_path
      expect(page).to have_link 'like一覧', href: likes_path(user)
      expect(page).to have_link 'ユーザー一覧', href: users_path
      expect(page).to have_link '', href: notifications_path
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link 'サインアウト', href: destroy_user_session_path
    end
  end
end
